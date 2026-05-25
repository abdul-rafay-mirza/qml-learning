import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami


Kirigami.Page {
    title: "Color Controls"

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
            color: root.activeColorRectangle
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
}