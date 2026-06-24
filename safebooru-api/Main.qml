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
                Layout.fillWidth:    true
                Layout.topMargin:    Kirigami.Units.smallSpacing
                Layout.bottomMargin: Kirigami.Units.smallSpacing

                Kirigami.SearchField {
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

            MasonryView {
                Layout.fillWidth:  true
                Layout.fillHeight: true

                model:       root.imagesList
                columnWidth: 240
                minColumns:  2

                // Aspect ratio lives here, not on the delegate.
                aspectRatioOf: (item) => (item.width > 0 && item.height > 0)
                                         ? item.width / item.height
                                         : 1.5

                delegate: ImageCard {
                    // modelData and modelIndex are provided by MasonryView automatically.
                    imageUrl: modelData.url
                }

                onTileClicked: (index, data) => {
                    console.log("Tapped tile", index, data.url)
                }
            }
        }
    }
}
