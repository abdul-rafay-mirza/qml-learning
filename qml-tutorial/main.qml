import QtQuick
import QtQuick.Controls

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Python + QML App"

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            id: label
            text: "Hello from QML!"
            font.pixelSize: 24
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: "Click Me!"
            anchors.horizontalCenter: parent.horizontalCenter
            // Call the Python function when clicked
            onClicked: {
                backend.change_text()
            }
        }

        Button {
            text: "Say Hi!"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                backend.say_hi()
            }
        }

        Button {
            text: "Increase Size"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                backend.increase_size()
            }
        }
    }

    // A JavaScript function that Python can call
    function updateText(newText) {
        label.text = newText
    }

    function makeTextBig() {
        label.font.pixelSize++
    }
}