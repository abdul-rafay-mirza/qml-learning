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
            console.log("QML Received images:", root.imagesList)
        }
    }

    pageStack.initialPage: Kirigami.Page {
        title: "SafeBooru"

        // Master layout container anchored tightly to the page boundaries
        ColumnLayout {
            anchors.fill: parent
            spacing: Kirigami.Units.smallSpacing

            RowLayout {
                id: searchRow
                Layout.fillWidth: true

                Kirigami.SearchField {
                    id: searchField
                    Layout.fillWidth:    true
                    Layout.leftMargin:   Kirigami.Units.largeSpacing
                    Layout.rightMargin:  Kirigami.Units.largeSpacing
                    Layout.topMargin:    Kirigami.Units.smallSpacing
                    Layout.bottomMargin: Kirigami.Units.smallSpacing
                    placeholderText: "Search character..."
                    onTextChanged: {
                        root.searchText = text
                    }
                }

                Controls.Button {
                    text: "Search"
                    Layout.rightMargin: Kirigami.Units.largeSpacing
                    onClicked: {
                        backend.get_search_query(root.searchText)
                    }
                }
            }

            // The ListView now safely expands to use up all remaining space
            ListView {
                id: imagesListView
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: root.imagesList
                clip: true
                spacing: Kirigami.Units.largeSpacing

                Controls.ScrollBar.vertical: Controls.ScrollBar {
                    policy: Controls.ScrollBar.AsNeeded
                    minimumSize: 0.05
                }

                delegate: Item {
                    width: imagesListView.width
                    height: 500

                    ImageCard {
                        anchors.horizontalCenter: parent.horizontalCenter
                        imageUrl: modelData
                    }
                } 
            }
        }
    }
}