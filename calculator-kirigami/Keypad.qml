import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

RowLayout {
    Layout.fillWidth: true
    Layout.fillHeight: true
    spacing: 5

    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: 3 // Takes 3/4 of horizontal space
        spacing: 5

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            NumericButton {
                text: "1"
                onClicked: {
                    backend.append_to_screen("1")
                }
            }

            NumericButton {
                text: "2"
                onClicked: {
                    backend.append_to_screen("2")
                }
            }

            NumericButton {
                text: "3"
                onClicked: {
                    backend.append_to_screen("3")
                }
            }
        }
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            NumericButton {
                text: "4"
                onClicked: {
                    backend.append_to_screen("4")
                }
            }

            NumericButton {
                text: "5"
                onClicked: {
                    backend.append_to_screen("5")
                }
            }

            NumericButton {
                text: "6"
                onClicked: {
                    backend.append_to_screen("6")
                }
            }
        }
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            NumericButton {
                text: "7"
                onClicked: {
                    backend.append_to_screen("7")
                }
            }

            NumericButton {
                text: "8"
                onClicked: {
                    backend.append_to_screen("8")
                }
            }

            NumericButton {
                text: "9"
                onClicked: {
                    backend.append_to_screen("9")
                }
            }
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: 1 // Takes 1/4 of horizontal space
        spacing: 5

        OperatorButton {
            text: "+"
            onClicked: {
                backend.append_to_screen("+")
            }
        }

        OperatorButton {
            text: "-"
            onClicked: {
                backend.append_to_screen("-")
            }
        }

        OperatorButton {
            text: "*"
            onClicked: {
                backend.append_to_screen("*")
            }
        }
        
        OperatorButton {
            text: "/"
            onClicked: {
                backend.append_to_screen("/")
            }
        }

        OperatorButton {
            text: "="
            onClicked: {
                // Plaeholder
                backend.evaluate()
            }
        }

        OperatorButton {
            text: "CLS"
            onClicked: {
                backend.clear_screen()
            }
        }
    }
}
