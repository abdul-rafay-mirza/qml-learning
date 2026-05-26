import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: "Passing Objects"

    pageStack.initialPage: Kirigami.Page {
        title: "Passing Python Objects in QML"
        Controls.Label {
            text: person1.name + person1.age + person1.gender
        }
    }
}