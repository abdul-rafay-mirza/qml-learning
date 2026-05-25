import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: "Layout Demo"

    pageStack.initialPage: Kirigami.Page {
        title: "Layout Demo"

        ColumnLayout {
            anchors.fill: parent
            spacing: 20

            RowLayout {
                Layout.fillWidth: true

                ColumnLayout {
                    Controls.Label {
                        text: "Slider 1"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Controls.Slider {
                        id: preferredWidthSlider1
                        orientation: Qt.Horizontal
                        value: 0
                        to: 10
                        Layout.fillWidth: true
                        snapMode: Controls.Slider.SnapAlways
                        stepSize: 1
                    }
                }

                ColumnLayout {
                    Controls.Label {
                        text: "Slider 2"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Controls.Slider {
                        id: preferredWidthSlider2
                        orientation: Qt.Horizontal
                        value: 0
                        to: 10
                        Layout.fillWidth: true
                        snapMode: Controls.Slider.SnapAlways
                        stepSize: 1
                    }
                }

                ColumnLayout {
                    Controls.Label {
                        text: "Slider 3"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Controls.Slider {
                        id: preferredWidthSlider3
                        orientation: Qt.Horizontal
                        value: 0
                        to: 10
                        Layout.fillWidth: true
                        snapMode: Controls.Slider.SnapAlways
                        stepSize: 1
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: preferredWidthSlider1.value
                    spacing: 5

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: '#2ff7a0'
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: '#ec3b3b'
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: '#ff00ee'
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: preferredWidthSlider2.value
                    spacing: 5

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: '#5b52d5'
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: '#a2f400'
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: '#00d9ff'
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: preferredWidthSlider3.value
                    spacing: 5

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: '#1c193f'
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: '#cd6c05'
                    }
                    
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: '#4f0d53'
                    }
                }
            }
        }
    }
}