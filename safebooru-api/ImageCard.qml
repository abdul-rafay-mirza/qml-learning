import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.AbstractCard {
    id: imageCard
    
    // Changed property name to avoid inner-scope name collisions
    property string imageUrl: ""

    width: 500
    height: 500
    leftPadding:   0
    rightPadding:  0
    topPadding:    0
    bottomPadding: 0

    contentItem: Rectangle {
        width: 500
        height: 500
        color: "transparent"

        Image {
            anchors.fill: parent
            // Explicit reference to the card component's property string
            source:       imageCard.imageUrl
            fillMode:     Image.PreserveAspectCrop
            smooth:       true
            visible:      imageCard.imageUrl !== ""
            
            // Helpful loading status printed to console
            onStatusChanged: {
                if (status === Image.Error) {
                    console.log("Failed to load image from:", source)
                }
            }
        }
    }
}