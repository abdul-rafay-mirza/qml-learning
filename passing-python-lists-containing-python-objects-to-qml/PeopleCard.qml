import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.Card {
    banner.title: modelData.name
    banner.titleIcon: "steam_icon_322170"
    banner.source: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwallpaperaccess.com%2Ffull%2F1760835.jpg&f=1&nofb=1&ipt=4c804223880338da91ae7fef7b54856a69ce882f810859fa2edcc8235f72027c"

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