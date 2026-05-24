import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Color change"

    ColumnLayout {
        id: centering_container
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 300
        spacing: 0

        Rectangle {
            id: shape
            width: 120
            height: 90
            color: "#333333"
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 10
        }

        RowLayout {
            id: buttons_container
            spacing: 5
            Layout.fillWidth: true
            Button {
                id: red
                text: "Red"
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                onClicked: { backend.change_color_red() }
            }
            Button {
                id: green
                text: "Green"
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                onClicked: { backend.change_color_green() }
            }
            Button {
                id: blue
                text: "Blue"
                Layout.fillWidth: true
                Layout.preferredWidth: 1
                onClicked: { backend.change_color_blue() }
            }
        }
    }

    function changeColorRed() {
        shape.color = "#FF0000"
    }

    function changeColorGreen() {
        shape.color = "#00FF00"
    }

    function changeColorBlue() {
        shape.color = "#0000FF"
    }
}