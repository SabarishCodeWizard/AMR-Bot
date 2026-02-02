import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: leftPanel
    color: appWindow.panelBg
    radius: 4
    border.color: appWindow.borderColor
    border.width: 1

    // Property to link to coordinate system if needed (from your main.qml binding)
    property var currentCoordinateSystem: null

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 16

        // --- 1. Map / Visualization Area ---
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: appWindow.inputBg
            radius: 4
            border.color: appWindow.borderColor
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: "Map Visualization Area"
                color: appWindow.textSec
                font.family: appWindow.fontFamily
                font.pixelSize: 16
            }
        }

        // --- 2. Bottom Controls ---
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            spacing: 20

            // Left Button Grid (Home, Mode, On/Off, Error)
            GridLayout {
                columns: 2
                rowSpacing: 8
                columnSpacing: 8

                // Helper to create the standard green buttons from the screenshot
                component ActionButton: Button {
                    Layout.preferredWidth: 90
                    Layout.preferredHeight: 35
                    background: Rectangle {
                        color: parent.down ? Qt.darker("#AED581", 1.2) : "#AED581" // Light Green
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "#1E1E2E"
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                ActionButton { text: "Home" }
                ActionButton {
                    text: "Mode"
                    // Logic to toggle RightPanel tabs could go here
                }
                ActionButton { text: "ON/OFF" }
                ActionButton { text: "Error" }
            }

            // Spacer
            Item { Layout.fillWidth: true }

            // Right AMR Selection Group
            RowLayout {
                spacing: 10

                Rectangle {
                    width: 60
                    height: 35
                    color: "#AED581" // Green label bg
                    radius: 4
                    Text {
                        anchors.centerIn: parent
                        text: "AMR"
                        font.bold: true
                        color: "#1E1E2E"
                    }
                }

                ComboBox {
                    Layout.preferredWidth: 140
                    Layout.preferredHeight: 35
                    model: ["AMR_01", "AMR_02", "AMR_03"]

                    background: Rectangle {
                        color: appWindow.inputBg
                        border.color: appWindow.borderColor
                        radius: 4
                    }
                    contentItem: Text {
                        leftPadding: 10
                        text: parent.displayText
                        color: appWindow.textMain
                        verticalAlignment: Text.AlignVCenter
                    }
                    popup: Popup {
                        y: parent.height - 1
                        width: parent.width
                        padding: 1
                        contentItem: ListView {
                            clip: true
                            implicitHeight: contentHeight
                            model: parent.parent.popup.visible ? parent.parent.model : null
                            delegate: ItemDelegate {
                                width: parent.width
                                text: modelData
                                palette.text: appWindow.textMain
                                background: Rectangle { color: hovered ? appWindow.hoverColor : appWindow.panelBg }
                            }
                        }
                        background: Rectangle {
                            color: appWindow.panelBg
                            border.color: appWindow.borderColor
                        }
                    }
                }
            }
        }
    }
}
