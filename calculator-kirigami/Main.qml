import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: "Simple Calculator App"
    width: 500
    height: 700

    property string display_string: ""

    pageStack.initialPage: CalculatorPage {
        displayed_text: display_string
    }

    // Javascript
    function display(thisString) {
        display_string = thisString
    }

    function getScreenText() {
        return display_string
    }
}