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

            // Direct invocation
            TapHandler {
                gesturePolicy: TapHandler.WithinBounds
                onTapped: {
                    backend.outer_clicked()
                }
            }

            Rectangle {
                id: innerRectangle
                anchors.centerIn: parent
                
                width: 200
                height: 60

                // Signal-handler pattern / event-driven pattern
                signal innerClicked()
 
                color: '#000000'
                border.color: '#ffffff'
                border.width: 2
                radius: 12

                TapHandler {
                    // Removes the outer rectangle from being clicked using TapHandler.WithinBounds
                    gesturePolicy: TapHandler.WithinBounds
                    onTapped: innerRectangle.innerClicked()
                }

                onInnerClicked: {
                    backend.inner_clicked()
                }

                Controls.Label {
                    anchors.fill: parent
                    
                    text: "Click Me!"
                    color: "#ffffff"

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    
                    font.bold: true
                    font.pointSize: 14
                }
            }
        }
    }
}