import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Item {
    id: imageCard
    property string imageUrl: ""

    Rectangle {
        anchors.fill: parent
        radius: 6
        color:  Kirigami.Theme.alternateBackgroundColor
        clip:   true

        Image {
            id: img
            anchors.fill: parent
            source:       imageCard.imageUrl
            // Container already matches the image's aspect ratio, so
            // PreserveAspectFit fills cleanly with no letterboxing.
            fillMode:     Image.PreserveAspectFit
            smooth:       true
            asynchronous: true
            cache:        true

            onStatusChanged: {
                if (status === Image.Error)
                    console.log("Failed to load image:", source)
            }
        }

        // Placeholder while the network fetch is in-flight
        Rectangle {
            anchors.fill: parent
            color:   parent.color
            visible: img.status !== Image.Ready

            Controls.BusyIndicator {
                anchors.centerIn: parent
                running: img.status === Image.Loading
                visible: running
            }
        }
    }
}