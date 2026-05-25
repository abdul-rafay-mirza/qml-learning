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
            }

            NumericButton {
                text: "2"
            }

            NumericButton {
                text: "3"
            }
        }
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            NumericButton {
                text: "4"
            }

            NumericButton {
                text: "5"
            }

            NumericButton {
                text: "6"
            }
        }
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            NumericButton {
                text: "7"
            }

            NumericButton {
                text: "8"
            }

            NumericButton {
                text: "9"
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
        }

        OperatorButton {
            text: "-"
        }

        OperatorButton {
            text: "x"
        }
        
        OperatorButton {
            text: "/"
        }

        OperatorButton {
            text: "="
        }

        OperatorButton {
            text: "CLS"
        }
    }
}
