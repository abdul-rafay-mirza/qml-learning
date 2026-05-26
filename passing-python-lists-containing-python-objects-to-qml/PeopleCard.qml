import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.Card {
    banner.title: modelData.name
    width : id_peopleList.width
    height: implicitHeight

    contentItem: ColumnLayout {
        spacing: 4
        
        Controls.Label {
            Layout.fillWidth: true
            text: "Age: " + modelData.age
            wrapMode: Text.Wrap
        }

        Controls.Label {
            Layout.fillWidth: true
            text: "Gender: " + modelData.gender
            wrapMode: Text.Wrap
        }
    }
}