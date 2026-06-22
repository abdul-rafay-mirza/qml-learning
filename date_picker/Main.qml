import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kirigamiaddons.formcard as FormCard
import org.kde.kirigamiaddons.dateandtime as DateAndTime

Kirigami.ApplicationWindow {
    width: 500
    height: 400
    visible: true

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        Controls.Button {
            text: "Pick date"
            onClicked: picker.open()
        }

        WideDatePopup {
            id: picker
            popupWidth: 400

            onAccepted: {
                console.log("Chosen:", value)
            }
        }
    }
}