import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

/*
imagine you are building an app that downloads files. You create a custom component called FileDownloader.qml. When it finishes downloading a file, it needs to tell the rest of the app:

1. The name of the file (string)
2. How big the file was (int in megabytes)

A parameterized signal is a way to send information from the component to the outside world. In this case, our component is FileDownloader, it does something, has some inforation (fine name and size) that needs to be passed to the application.
*/

Kirigami.ApplicationWindow {
    id: root
    title: "File Downloader"

    property var name: "Downloading..."
    property var size: 0

    pageStack.initialPage: Kirigami.Page {
        title: "File Downloader"

        FileDownloader {
            // fileName and fileSizeMb will come from FileDownloader.qml (line 18)
            onDownloadComplete: (fileName, fileSizeMb) => {
                name = fileName
                size = fileSizeMb
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Controls.Label {
                id: fileNameLabel
                text: "File Name: " + name 
            }

            Controls.Label {
                id: fileSizeLabel
                text: "File Size: " + size 
            }

            Controls.Label {
                id: downloadFinishConfirmation
                text: "Download Finished!"
                visible: root.size > 0 // Property Binding https://doc.qt.io/qt-6/qtqml-syntax-propertybinding.html
            }
        }
    }
}