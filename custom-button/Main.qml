import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Custom Button"

    pageStack.initialPage: Kirigami.Page {
        title: "Custom Button - A Button made using a Rectangle"

        Rectangle {
            id: outerRectangle
            anchors.centerIn: parent
            width: 300
            height: 300

            color: "#000000"
            border.color: "#ffffff"
            border.width: 2
            radius: 12

            TapHandler {
                gesturePolicy: TapHandler.WithinBounds
                onTapped: {
                    backend.onOuterCliked()
                }
            }

            Rectangle {
                id: innerRectangle
                // Position it cleanly on the page instead of filling the whole screen
                anchors.centerIn: parent
                
                // Sizing your button explicitly
                width: 200
                height: 60

                // 1. STYLING: Black background with a white border
                color: '#000000'        // Filled with black
                border.color: '#ffffff' // White border
                border.width: 2         // Visible border thickness
                radius: 12              // Rounded edges (increase for a pill shape)

                TapHandler {
                    // Removes the outer rectangle from being clicked
                    gesturePolicy: TapHandler.WithinBounds
                    onTapped: {
                        backend.onInnerCliked()
                    }
                }

                Controls.Label {
                    // 2. STRETCHING: Force the text label boundaries to match the entire rectangle
                    anchors.fill: parent
                    
                    text: "Click Me!"
                    color: "#ffffff"    // Changed to white so it's visible on the black background

                    // 3. CENTER TEXT INTERNALLY: Since the label box matches the rectangle size,
                    // we tell the text alignment engine to center itself inside its own container bounds.
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    
                    font.bold: true
                    font.pointSize: 14
                }
            }
        }
    }
}