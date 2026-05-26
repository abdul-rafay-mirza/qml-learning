import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.Card {
    banner.title: modelData.name
    width: id_animeList.width
    height: implicitHeight
}