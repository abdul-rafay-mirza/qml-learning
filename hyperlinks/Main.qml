import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Hyperink"

    pageStack.initialPage: Kirigami.Page {
        title: "Hyperink"

        ColumnLayout {
            Controls.Label {
                id: label
                text: 'Check out <a href="https://google.com">Hyperink</a> for details.'
                textFormat: Text.RichText // Tells Qt to parse the HTML <a> tag

                onLinkActivated: (link) => {
                    // link here will be the link from <a> tag
                    Qt.openUrlExternally(link)
                }
            }

            Kirigami.UrlButton {
                text: "Visit Hyperink"
                url: "https://google.com"
            }
        }
    }
}