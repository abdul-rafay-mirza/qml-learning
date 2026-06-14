import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

ColumnLayout {
    property var title
    property var bannerImage

    Rectangle {
        Layout.fillWidth: true
        implicitHeight: 250
        clip: true

        Image {
            anchors.fill: parent
            source: bannerImage || ""
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            mipmap: true
        }
    }

    Rectangle {
        Layout.fillWidth: true
        implicitHeight: titleLabel.implicitHeight
        color: "transparent"

        Controls.Label {
            id: titleLabel
            text: title || "Loading..."
            anchors.centerIn: parent
            // horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            width: parent.width
        }
    }
}