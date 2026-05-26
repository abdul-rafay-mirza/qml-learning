import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: "Passing List Containing Objects"

    property var peopleList

    pageStack.initialPage: Kirigami.Page {
        title: "Passing List Containing Objects"

        ListView {
            anchors.fill: parent
            id: id_peopleList
            model: peopleList
            clip: true
            spacing: 8
            delegate: PeopleCard{}
        }
    }

    function getPeople(_people) {
        peopleList = _people
    }
}