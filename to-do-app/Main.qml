import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: "To-do App"

    property list<string> notesList

    pageStack.initialPage: Kirigami.Page {
        title: "To-do App"

        ColumnLayout {
            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.fillWidth: true

            RowLayout {
                Layout.fillWidth: true

                Controls.TextField {
                    id: textfield
                    placeholderText: "Go do your homework"
                    Layout.fillWidth: true
                    Layout.preferredWidth: 2
                }

                Controls.Button {
                    text: "Set Task"
                    Layout.fillWidth: true
                    Layout.preferredWidth: 1
                    onClicked: {
                        backend.get_text_from_text_field(textfield.text)
                    }
                }
            }

            ToDoCardsList {
                model: notesList
            }
        }
    }

    function getNotes(notesArray) {
        // console.log(notesArray)
        notesList = notesArray
    }
}