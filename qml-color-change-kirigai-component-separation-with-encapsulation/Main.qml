import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    visible: true
    width: 400
    height: 300
    title: "Color change"

    property color activeColorRectangle: "#333333"

    // The first page shown (initial page in the bottom of the page stack)
    pageStack.initialPage: ColorPage{
        rectangleColor: activeColorRectangle
    }


    function changeColorRed() {
        root.activeColorRectangle = "#FF0000"
    }

    function changeColorGreen() {
        root.activeColorRectangle = "#00FF00"
    }

    function changeColorBlue() {
        root.activeColorRectangle = "#0000FF"
    }
}