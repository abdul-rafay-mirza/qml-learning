import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    visible: true
    width: 400
    height: 300
    title: "Color change"

    // Bind a state property for the rectangle's color
    property color activeColor: "#333333"

    // Your Python backend calls these functions on the root window
    function changeColorRed() { root.activeColor = "#FF0000" }
    function changeColorGreen() { root.activeColor = "#00FF00" }
    function changeColorBlue() { root.activeColor = "#0000FF" }

    // Kirigami uses a PageStack for navigation
    pageStack.initialPage: Kirigami.Page {
        title: "Color Controls"

        ColumnLayout {
            anchors.centerIn: parent
            width: 300
            // Use Kirigami standardized spacing instead of hardcoded numbers
            spacing: Kirigami.Units.largeSpacing

            Rectangle {
                id: shape
                width: 120
                height: 90
                color: root.activeColor
                Layout.alignment: Qt.AlignHCenter
            }

            RowLayout {
                // Standardized small spacing
                spacing: Kirigami.Units.smallSpacing
                Layout.fillWidth: true

                Button {
                    text: "Red"
                    Layout.fillWidth: true
                    onClicked: { backend.change_color_red() }
                }
                Button {
                    text: "Green"
                    Layout.fillWidth: true
                    onClicked: { backend.change_color_green() }
                }
                Button {
                    text: "Blue"
                    Layout.fillWidth: true
                    onClicked: { backend.change_color_blue() }
                }
            }
        }
    }
}