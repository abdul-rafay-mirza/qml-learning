import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Controls.Dialog {
    id: animeCardDialog
    title: "You Clicked on an Anime Card!"
    modal: true // Darkens the background
    anchors.centerIn: parent

    // Body Content
    contentItem: Controls.Label {
        text: "Some text in contentItem"
    }

    // Footer Buttons (built-in)
    standardButtons: Controls.Dialog.Ok | Controls.Dialog.Cancel

    onAccepted: {
        console.log("Accepted")
    }
    onRejected: {
        console.log("Cancelled")
    }
}