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

    Connections {
        target: backend

        function onAnimePageLoaded(_title, _bannerImage) {
            animeTitle = _title
            animeBannerImage = _bannerImage
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
            }

            Item { Layout.fillHeight: true }
        }
    }
}