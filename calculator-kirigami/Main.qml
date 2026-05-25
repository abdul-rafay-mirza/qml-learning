import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: "Simple Calculator App"

    property string display: ""

    pageStack.initialPage: CalculatorPage {
        displayed_text: thisString
    }

    // Javascript
    function display(thisString) {
        display = thisString
    }
}