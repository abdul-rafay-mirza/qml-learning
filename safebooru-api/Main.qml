import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: "SafeBooru"

    property string searchText: ""
    property var imagesList: []

    Connections {
        target: backend
        function onGetResponse(_list) {
            root.imagesList = _list
        }
    }

    pageStack.initialPage: Kirigami.Page {
        title: "SafeBooru"

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            RowLayout {
                Layout.fillWidth: true
                Layout.topMargin:    Kirigami.Units.smallSpacing
                Layout.bottomMargin: Kirigami.Units.smallSpacing

                Kirigami.SearchField {
                    id: searchField
                    Layout.fillWidth:   true
                    Layout.leftMargin:  Kirigami.Units.largeSpacing
                    Layout.rightMargin: Kirigami.Units.largeSpacing
                    placeholderText: "Search character..."
                    onTextChanged: root.searchText = text
                    onAccepted:    backend.get_search_query(root.searchText)
                }

                Controls.Button {
                    text: "Search"
                    Layout.rightMargin: Kirigami.Units.largeSpacing
                    onClicked: backend.get_search_query(root.searchText)
                }
            }

            // ── Masonry gallery ──────────────────────────────────────────────
            Item {
                id: gallery
                Layout.fillWidth:  true
                Layout.fillHeight: true

                // Responsive: ~240 px per column, minimum 2
                property int  numColumns: Math.max(2, Math.floor(width / 240))
                property real gap: Kirigami.Units.smallSpacing

                // Pure JS: compute every item's x/y/w/h from the image's
                // native pixel dimensions returned by the Safebooru API.
                // Reacts automatically when imagesList or gallery width changes.
                property var masonryData: {
                    if (gallery.width <= 0 || root.imagesList.length === 0)
                        return { positions: [], totalHeight: 0 }

                    var cols  = gallery.numColumns
                    var g     = gallery.gap
                    var colW  = (gallery.width - g * (cols - 1)) / cols
                    var colH  = new Array(cols).fill(0.0)
                    var pos   = []

                    for (var i = 0; i < root.imagesList.length; i++) {
                        var img  = root.imagesList[i]
                        var ar   = (img.width > 0 && img.height > 0)
                                   ? img.width / img.height
                                   : 1.5          // sensible fallback
                        var h    = colW / ar

                        // Place in the shortest column
                        var sc = 0
                        for (var c = 1; c < cols; c++)
                            if (colH[c] < colH[sc]) sc = c

                        pos.push({ x: sc * (colW + g), y: colH[sc], w: colW, h: h })
                        colH[sc] += h + g
                    }

                    var totalH = 0
                    for (var c = 0; c < cols; c++)
                        if (colH[c] > totalH) totalH = colH[c]

                    return { positions: pos, totalHeight: totalH }
                }

                Flickable {
                    anchors.fill: parent
                    contentWidth:  width
                    contentHeight: gallery.masonryData.totalHeight
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds

                    Controls.ScrollBar.vertical: Controls.ScrollBar {
                        policy:      Controls.ScrollBar.AsNeeded
                        minimumSize: 0.05
                    }

                    Repeater {
                        model: root.imagesList

                        delegate: Item {
                            // Guard against the brief instant when positions
                            // and model count could diverge during a list swap
                            readonly property var pos:
                                index < gallery.masonryData.positions.length
                                ? gallery.masonryData.positions[index]
                                : ({ x: 0, y: 0, w: 0, h: 0 })

                            x:      pos.x
                            y:      pos.y
                            width:  pos.w
                            height: pos.h

                            ImageCard {
                                anchors.fill: parent
                                imageUrl: modelData.url
                            }
                        }
                    }
                }
            }
        }
    }
}