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
                id: searchRow
                Layout.fillWidth: true
                Layout.topMargin:    Kirigami.Units.smallSpacing
                Layout.bottomMargin: Kirigami.Units.smallSpacing

                Kirigami.SearchField {
                    id: searchField
                    Layout.fillWidth:    true
                    Layout.leftMargin:   Kirigami.Units.largeSpacing
                    Layout.rightMargin:  Kirigami.Units.largeSpacing
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

            // ── MASONRY GALLERY WITH LISTVIEW VIRTUALIZATION ─────────────────
            Item {
                id: gallery
                Layout.fillWidth:  true
                Layout.fillHeight: true

                property int  numColumns: Math.max(2, Math.floor(width / 240))
                property real gap: Kirigami.Units.smallSpacing

                // Distributes raw image items into dynamic column arrays
                property var masonryData: {
                    if (gallery.width <= 0 || root.imagesList.length === 0)
                        return { columns: [], totalHeight: 0 }

                    var cols  = gallery.numColumns
                    var g     = gallery.gap
                    var colW  = (gallery.width - g * (cols - 1)) / cols
                    var colH  = new Array(cols).fill(0.0)
                    
                    // Initialize empty buckets for each column
                    var columnBuckets = Array.from({ length: cols }, () => [])

                    for (var i = 0; i < root.imagesList.length; i++) {
                        var img = root.imagesList[i]
                        var ar  = (img.width > 0 && img.height > 0) ? img.width / img.height : 1.5
                        var h   = colW / ar

                        // Select the shortest column path
                        var sc = 0
                        for (var c = 1; c < cols; c++) {
                            if (colH[c] < colH[sc]) sc = c
                        }

                        // Store image data alongside its precomputed target height
                        columnBuckets[sc].push({
                            url: img.url,
                            computedHeight: h
                        })
                        colH[sc] += h + g
                    }

                    var totalH = 0
                    for (var c = 0; c < cols; c++) {
                        if (colH[c] > totalH) totalH = colH[c]
                    }

                    return { columns: columnBuckets, totalHeight: totalH }
                }

                Flickable {
                    id: masterFlickable
                    anchors.fill: parent
                    contentWidth:  width
                    contentHeight: gallery.masonryData.totalHeight
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds

                    Controls.ScrollBar.vertical: Controls.ScrollBar {
                        policy:      Controls.ScrollBar.AsNeeded
                        minimumSize: 0.05
                    }

                    // Columns row is bounded tightly to the viewport window to enable virtualization
                    RowLayout {
                        width:  masterFlickable.width
                        height: masterFlickable.height
                        y:      masterFlickable.contentY // Follows scroll view precisely
                        spacing: gallery.gap

                        Repeater {
                            model: gallery.numColumns

                            delegate: ListView {
                                id: columnListView
                                Layout.fillWidth:  true
                                Layout.fillHeight: true
                                spacing:           gallery.gap
                                interactive:       false // Let masterFlickable handle touch/wheel inputs
                                clip:              true

                                // Master scrolling mirror
                                contentY: masterFlickable.contentY

                                // Safety guard against async context modifications
                                model: (gallery.masonryData.columns && index < gallery.masonryData.columns.length)
                                       ? gallery.masonryData.columns[index]
                                       : []

                                delegate: Item {
                                    width:  columnListView.width
                                    height: modelData.computedHeight

                                    ImageCard {
                                        anchors.fill: parent
                                        imageUrl:     modelData.url
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}