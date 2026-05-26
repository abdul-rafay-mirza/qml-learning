import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: "Anime List"

    property var _animeList

    pageStack.initialPage: AnimePage {
        animeList: _animeList
    }

    function pythonToQML(listOfAnime) {
        _animeList = listOfAnime
    }
}