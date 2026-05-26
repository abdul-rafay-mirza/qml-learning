import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.Card {
    banner.title: modelData.name
    banner.titleIcon: "steam_icon_322170"
    width: id_peopleList.width
    height: implicitHeight

    contentItem: ColumnLayout {
        spacing: 4

        Kirigami.IconTitleSubtitle {
            icon.name: "view-calendar-birthday"
            title: "Age: " + modelData.age
            Layout.fillWidth: true
        }

        Kirigami.IconTitleSubtitle {
            icon.name: "gender"
            title: "Gender: " + modelData.gender
            Layout.fillWidth: true
        }
    }
}