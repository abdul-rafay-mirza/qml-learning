import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import "components"

Kirigami.ApplicationWindow {
    id: root
    title: "Anime Page"

    property var animeTitle
    property var animeBannerImage
    property var animeCoverImage
    property var animeDescription

    Connections {
        target: backend

        function onAnimePageLoaded(_title, _bannerImage, _coverImage, _description) {
            animeTitle = _title
            animeBannerImage = _bannerImage
            animeCoverImage = _coverImage
            animeDescription = _description
        }
    }

    pageStack.initialPage: Kirigami.Page {
        title: "Anime Page"

        ColumnLayout {
            anchors.fill: parent
            Layout.fillWidth: true
            // spacing: 5

            Header {
                Layout.fillWidth: true
                title: animeTitle
                bannerImage: animeBannerImage
                coverImage: animeCoverImage
                description: animeDescription
            }

            Item { Layout.fillHeight: true }
        }
    }
}