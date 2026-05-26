import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.AbstractCard {
    id: animeCard


    // Public API — matches your Anime Python class
    property string animeName
    property string formatType
    property string status
    property int    episodes
    property string coverImage
    property int    averageScore

    signal cardClicked()
    signal ratingClicked()

    // Geometry
    width: id_animeList.width
    implicitHeight: Math.max(150, contentItem.implicitHeight + 10)
    leftPadding:   0
    rightPadding:  0
    topPadding:    0
    bottomPadding: 0

    contentItem: RowLayout {
        anchors {
            fill:         parent
            bottomMargin: 5
        }
        spacing: 0

        TapHandler {
            gesturePolicy: TapHandler.WithinBounds
            onTapped: {
                animeCard.cardClicked()
                backend.onCardClicked()
            }
        }

        // Cover image
        Rectangle {
            Layout.preferredWidth: 90
            Layout.fillHeight:     true
            color: Kirigami.ColorUtils.tintWithAlpha(
                       Kirigami.Theme.backgroundColor,
                       Kirigami.Theme.textColor,
                       0.05)
            clip: true // crop the overlowing bits

            Image {
                anchors.fill: parent          // stretches the Image item to match the parent Rectangle's size
                source: animeCard.coverImage
                fillMode: Image.PreserveAspectCrop  // scales the image UP until it fills the item completely,
                                                    // preserving aspect ratio, cropping whatever overflows
                                                    // (that's why clip: true is needed on the parent)
                smooth: true                  // uses smooth filtering when scaling — looks better but
                                            // slightly more expensive. false = pixelated/nearest neighbour
                visible: animeCard.coverImage !== ""  // hides the Image item entirely if there is no URL,
                                                    // which lets the fallback Kirigami.Icon show instead
}

            Kirigami.Icon {
                anchors.centerIn: parent
                source:  "image-missing"
                width:   32; height: 32
                visible: animeCard.coverImage === ""
                color:   Kirigami.Theme.disabledTextColor
            }
        }

        // Text
        ColumnLayout {
            Layout.fillWidth:   true
            Layout.fillHeight:  true
            Layout.leftMargin:  14
            Layout.rightMargin: 12
            Layout.topMargin:   10
            spacing: 2

            // Anime name
            Controls.Label {
                Layout.fillWidth: true
                text:  animeCard.animeName
                color: Kirigami.Theme.textColor
                font { bold: true; pixelSize: 15 }
                elide: Text.ElideRight
                maximumLineCount: 1
            }

            // Format + episodes
            Controls.Label {
                Layout.fillWidth: true
                text:  animeCard.formatType + " • " + animeCard.episodes + " eps"
                color: Kirigami.Theme.highlightColor
                font.pixelSize: 12
            }

            // Status
            Controls.Label {
                Layout.fillWidth: true
                text:  animeCard.status
                color: Kirigami.Theme.disabledTextColor
                font.pixelSize: 12
            }

            Item { Layout.fillHeight: true }

            // Score row
            RowLayout {
                Layout.fillWidth: true
                spacing: 4

                TapHandler {
                    gesturePolicy: TapHandler.WithinBounds
                    onTapped:{
                        animeCard.ratingClicked()
                        backend.onRatingClicked()
                    }
                }

                Kirigami.Icon {
                    source: "starred-symbolic"
                    width:  16; height: 16
                    color:  animeCard.averageScore > 0
                            ? Kirigami.Theme.highlightColor
                            : Kirigami.Theme.disabledTextColor
                }
                Controls.Label {
                    text:  animeCard.averageScore > 0
                           ? animeCard.averageScore + " / 100"
                           : "—"
                    color: animeCard.averageScore > 0
                           ? Kirigami.Theme.textColor
                           : Kirigami.Theme.disabledTextColor
                    font.pixelSize: 13
                }
            }
        }
    }

    // Score progress bar at the bottom
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left:   parent.left
        anchors.right:  parent.right
        height: 4
        color: Kirigami.ColorUtils.tintWithAlpha(
                   Kirigami.Theme.backgroundColor,
                   Kirigami.Theme.positiveTextColor,
                   0.3)

        Rectangle {
            width:  parent.width * (animeCard.averageScore / 100)
            height: parent.height
            color:  Kirigami.Theme.positiveTextColor

            Behavior on width {
                NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
            }
        }
    }
}