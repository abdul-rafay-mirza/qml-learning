import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

// ListView supports Gesture Scrolling as well, so you can hold the mouse and move up and down to scroll
ListView {
    id: taskListView
    Layout.fillWidth: true
    Layout.fillHeight: true
    clip: true

    delegate: Kirigami.Card {
        width: taskListView.width
        contentItem: Controls.Label {
            text: modelData
            wrapMode: Text.Wrap
        }
    }

    // ATTACH THE VISUAL SCROLLBAR
    Controls.ScrollBar.vertical: Controls.ScrollBar {
        active: true // Makes it visible when scrolling or hovering
        policy: Controls.ScrollBar.AsNeeded // Only shows up if there are enough tasks to scroll
    }
}