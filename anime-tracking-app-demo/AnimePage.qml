import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.Page {
    title: "Anime List"

    property var animeList

    ListView {
        id: id_animeList
        anchors.fill: parent
        model: animeList

        delegate: AnimeCard {
            animeName: modelData.name
            formatType: modelData.formatType
            status: modelData.status
            episodes: modelData.episodes
            coverImage: modelData.coverImage
            averageScore: modelData.averageScore
        }
    }
}