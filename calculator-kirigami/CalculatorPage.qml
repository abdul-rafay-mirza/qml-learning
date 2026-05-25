import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami


Kirigami.Page {
    title: "Calculator Application"

    property string displayed_text

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        Rectangle {
            color: "#000000"
            Layout.fillWidth: true
            // Give the display an exact height, or it will collapse to 0
            Layout.preferredHeight: 80

            Label {
                text: displayed_text
                color: "#ffffff"
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: 10
            }
        }

        Keypad {}
    }
}