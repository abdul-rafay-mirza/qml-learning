import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import "Components/Cards/"
import "Components/Dialogs/"


Kirigami.Page {
    title: "Anime List"

    property var animeList

    // AnimePage.qml cannot access the id animeCardDialog in Components/Dialogs/AnimeCardDialog.qml. For that, we first have to instantiate the id in AnimePAge.qml so that it can read the id
    AnimeCardDialog {
        id: animeCardDialog
    }

    // The same process will apply for accessing Components/Dialogs/RatingDialog.qml
    RatingDialog {
        id: ratingDialog
    }

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

            // These properties were created because we created signals in AnimeCard called cardClicked and ratingClicked
            // QML automatically makes onCardClicked and onRatingClicked because of those signals
            onCardClicked: {
                backend.on_card_clicked()

                // Using the id in Components/Dialogs/AnimeCardDialog.qml
                animeCardDialog.open()
            }

            onRatingClicked: {
                backend.on_rating_clicked()

                // Using the id in Components/Dialog/RatingDialog.qml
                ratingDialog.open()
            }
        }
    }
}