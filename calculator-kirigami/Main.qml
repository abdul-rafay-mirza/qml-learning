import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: "Simple Calculator App"

    pageStack.initialPage: CalculatorPage {
        displayed_text: "Some text here"
    }
}