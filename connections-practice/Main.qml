import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

/*
Use connections when python emits a signal and you want QML to react to it

we were doing QML -> Python before, by emitting a signal in QML and having a Slot in Python so that Python can listen to it.

Say Python finishes a background task and wants to update the UI. Python emits a signal, and QML listens with Connections
*/
Kirigami.ApplicationWindow {
    title: "Connections Practice"

    Connections {
        target: backend

        function onCountReachesTen(count) {
            label.text = "Congrats, you clicked the button at least " + count + " times!"
        }
    }

    pageStack.initialPage: Kirigami.Page {
        title: "Connections Practice"

        RowLayout {
            anchors.fill: parent
            Layout.fillWidth: true
            spacing: 20

            Controls.Button {
                text: "Click Me"
                onClicked: backend.clicked()
            }

            Controls.Label {
                id: label
                text: ""
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}