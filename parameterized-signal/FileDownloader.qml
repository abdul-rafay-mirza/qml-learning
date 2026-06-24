import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Item {
    // 1. We declare the signal and what data it will carry
    signal downloadComplete(fileName: string, fileSizeMb: int)

    // A timer to simulate a 3-second download
    Timer {
        interval: 3000
        running: true
        repeat: false
        
        onTriggered: {
            // 2. The download finished! We EMIT the signal and pass the actual values
            downloadComplete("vacation_photo.jpg", 15)
        }
    }
}