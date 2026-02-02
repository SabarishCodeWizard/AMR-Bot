import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: rightPanel
    color: appWindow.panelBg
    radius: 4
    border.color: appWindow.borderColor
    border.width: 1

    // Alias for the manual view (referenced as 'jogTab' in your main.qml)
    property alias jogTab: manualView

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 0

        // --- Header ---
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "AMR Fleet Management System"
            font.family: appWindow.fontFamily
            font.bold: true
            font.pixelSize: 18
            color: appWindow.textMain
            Layout.bottomMargin: 10
        }

        // --- Tab Bar (To switch between Auto/Manual views) ---
        TabBar {
            id: modeBar
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            position: TabBar.Header

            background: Rectangle { color: "transparent" }

            TabButton {
                text: "Auto Mode"
                width: implicitWidth
                contentItem: Text {
                    text: parent.text
                    color: parent.checked ? appWindow.accentColor : appWindow.textSec
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
                background: Rectangle { color: parent.checked ? appWindow.hoverColor : "transparent"; radius: 4 }
            }
            TabButton {
                text: "Manual Mode"
                width: implicitWidth
                contentItem: Text {
                    text: parent.text
                    color: parent.checked ? appWindow.accentColor : appWindow.textSec
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                }
                background: Rectangle { color: parent.checked ? appWindow.hoverColor : "transparent"; radius: 4 }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"
            border.color: appWindow.borderColor
            border.width: 1

            StackLayout {
                anchors.fill: parent
                anchors.margins: 10
                currentIndex: modeBar.currentIndex

                // --- VIEW 1: AUTO MODE (Image 1) ---
                Item {
                    id: autoView

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 20

                        // Header Label
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 30
                            color: "#FFAB40" // Orange
                            radius: 4
                            Text {
                                anchors.centerIn: parent
                                text: "Auto"
                                color: "white"
                                font.bold: true
                            }
                        }

                        // Button Grid
                        GridLayout {
                            columns: 2
                            rowSpacing: 10
                            columnSpacing: 20

                            // Greenish Label Buttons
                            component StatusLabel: Rectangle {
                                Layout.preferredWidth: 80
                                Layout.preferredHeight: 30
                                color: "#AED581" // Light Green
                                radius: 4
                                property string text
                                Text { anchors.centerIn: parent; text: parent.text; font.bold: true; color: "#1E1E2E" }
                            }

                            // White Action Buttons
                            component CmdButton: Button {
                                Layout.preferredWidth: 80
                                Layout.preferredHeight: 30
                                background: Rectangle {
                                    color: parent.down ? "#ddd" : "#fff"
                                    border.color: "#999"
                                    radius: 4
                                }
                                contentItem: Text {
                                    text: parent.text;
                                    color: "#333";
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }

                            StatusLabel { text: "Current" }
                            CmdButton   { text: "point" }

                            StatusLabel { text: "Set" }
                            CmdButton   { text: "Point" }

                            StatusLabel { text: "path" }
                            CmdButton   { text: "preview" }
                        }

                        // Start/Stop
                        Button {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            background: Rectangle {
                                color: "#AED581"
                                radius: 4
                            }
                            contentItem: Text {
                                text: "Start/Stop"
                                font.bold: true
                                color: "#1E1E2E"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        Item { Layout.fillHeight: true } // Spacer
                    }
                }

                // --- VIEW 2: MANUAL MODE (Image 2) ---
                Item {
                    id: manualView

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 20

                        // Header Label
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 30
                            color: "#AED581" // Green
                            radius: 4
                            Text {
                                anchors.centerIn: parent
                                text: "Manual"
                                color: "#1E1E2E"
                                font.bold: true
                            }
                        }

                        // D-Pad Control
                        Item {
                            Layout.preferredWidth: 160
                            Layout.preferredHeight: 160
                            Layout.alignment: Qt.AlignHCenter

                            // Custom D-Pad Shapes using Canvas or just Rotated Rectangles/Text
                            // Using Buttons for simplicity and hit-testing

                            // Up
                            Button {
                                x: 55; y: 0; width: 50; height: 50
                                background: Rectangle { color: parent.down ? appWindow.accentColor : "#5C6BC0"; radius: 25 }
                                contentItem: Text { text: "▲"; color: "white"; font.pixelSize: 20; anchors.centerIn: parent }
                            }
                            // Left
                            Button {
                                x: 0; y: 55; width: 50; height: 50
                                background: Rectangle { color: parent.down ? appWindow.accentColor : "#5C6BC0"; radius: 25 }
                                contentItem: Text { text: "◄"; color: "white"; font.pixelSize: 20; anchors.centerIn: parent }
                            }
                            // Center
                            Button {
                                x: 55; y: 55; width: 50; height: 50
                                background: Rectangle { color: "#3949AB"; radius: 25; border.color: "white" }
                            }
                            // Right
                            Button {
                                x: 110; y: 55; width: 50; height: 50
                                background: Rectangle { color: parent.down ? appWindow.accentColor : "#5C6BC0"; radius: 25 }
                                contentItem: Text { text: "►"; color: "white"; font.pixelSize: 20; anchors.centerIn: parent }
                            }
                            // Down
                            Button {
                                x: 55; y: 110; width: 50; height: 50
                                background: Rectangle { color: parent.down ? appWindow.accentColor : "#5C6BC0"; radius: 25 }
                                contentItem: Text { text: "▼"; color: "white"; font.pixelSize: 20; anchors.centerIn: parent }
                            }
                        }

                         Item { Layout.fillHeight: true } // Spacer
                    }
                }
            }
        }

        // --- Bottom Section: Properties Tab ---
        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: appWindow.borderColor
            Layout.topMargin: 10
            Layout.bottomMargin: 10
        }

        Text {
            text: "Properties Tab"
            font.bold: true
            color: appWindow.textMain
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 10
        }

        GridLayout {
            columns: 3
            columnSpacing: 10
            rowSpacing: 10
            Layout.fillWidth: true

            // Helper for labels
            component PropLabel: Label {
                Layout.preferredWidth: 80
                background: Rectangle { color: "#AED581"; radius: 4 }
                color: "#1E1E2E"
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                padding: 5
            }

            // Helper for Inputs (Triggers Keypad)
            component PropInput: TextField {
                Layout.fillWidth: true
                placeholderText: "0.0"
                color: appWindow.textMain
                background: Rectangle {
                    color: appWindow.inputBg
                    border.color: parent.activeFocus ? appWindow.primaryColor : appWindow.borderColor
                    radius: 4
                }
                // Trigger the global keypad on press
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        parent.forceActiveFocus()
                        appWindow.showKeypad(parent)
                    }
                }
            }

            // Row 1
            PropLabel { text: "Speed" }
            PropInput {}
            Text { text: "M/s"; color: appWindow.textSec }

            // Row 2
            PropLabel { text: "Linear v" }
            PropInput {}
            Text { text: "M/s"; color: appWindow.textSec }

            // Row 3
            PropLabel { text: "Angular v" }
            PropInput {}
            Text { text: "dec/s"; color: appWindow.textSec }
        }

        // --- E-STOP Button ---
        Button {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            Layout.topMargin: 15
            background: Rectangle {
                color: parent.down ? Qt.darker("#F57C00") : "#F57C00" // Orange/Red warning color
                radius: 4
                border.width: 2
                border.color: "#E65100"
            }
            contentItem: Text {
                text: "E-STOP"
                font.bold: true
                font.pixelSize: 16
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
