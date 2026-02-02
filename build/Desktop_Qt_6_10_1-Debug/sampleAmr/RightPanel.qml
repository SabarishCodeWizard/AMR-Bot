import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: rightPanelRoot

    // --- RECEIVE THEME ---
    property var theme

    color: theme.panelBg
    radius: 8
    border.color: theme.borderColor
    border.width: 1

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 16

        // =========================================
        // SECTION 1: CONTROL CENTER (30%)
        // =========================================
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 3
            spacing: 12

            // Header
            RowLayout {
                Layout.fillWidth: true
                spacing: 8
                Rectangle { width: 4; height: 16; color: theme.dangerColor; radius: 2 }
                Text {
                    text: "MISSION CONTROL"
                    color: theme.textSec
                    font.pixelSize: 11; font.bold: true; font.letterSpacing: 1.2
                }
            }

            // Mode Toggle Card
            Rectangle {
                Layout.fillWidth: true
                height: 56
                color: theme.inputBg
                radius: 6
                border.color: theme.borderColor

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 16

                    ColumnLayout {
                        spacing: 2
                        Text { text: "OPERATION MODE"; color: theme.textSec; font.pixelSize: 10; font.bold: true }
                        Text { text: "AUTOMATIC"; color: theme.primaryColor; font.bold: true; font.pixelSize: 14 }
                    }
                    Item { Layout.fillWidth: true }
                    Switch {
                        scale: 0.8
                        checked: true
                        // Customizing switch colors would go here in a full custom component
                    }
                }
            }

            // Select AMR Button
            Button {
                Layout.fillWidth: true
                height: 40
                background: Rectangle {
                    color: "transparent"
                    border.color: theme.primaryColor
                    border.width: 1
                    radius: 6
                    // color: parent.down ? Qt.rgba(theme.primaryColor.r, theme.primaryColor.g, theme.primaryColor.b, 0.1) : "transparent"
                }
                contentItem: Text {
                    text: "SELECT ACTIVE AMR"
                    color: theme.primaryColor
                    font.bold: true
                    font.pixelSize: 11
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            // Emergency Stop (Pushed to bottom of this section)
            Item { Layout.fillHeight: true }

            Button {
                Layout.fillWidth: true
                height: 48
                background: Rectangle {
                    color: parent.down ? "#b71c1c" : theme.dangerColor
                    radius: 6
                    // Add a subtle shadow or glow effect here for emphasis
                }
                contentItem: RowLayout {
                    anchors.centerIn: parent
                    spacing: 8
                    // You could add an icon here
                    Text {
                        text: "EMERGENCY STOP"
                        color: "white"
                        font.bold: true
                        font.pixelSize: 13
                        font.letterSpacing: 1
                    }
                }
            }
        }

        // =========================================
        // SECTION 2: TASK QUEUE (40%)
        // =========================================
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 4
            spacing: 12

            // Header
            RowLayout {
                Layout.fillWidth: true
                spacing: 8
                Rectangle { width: 4; height: 16; color: theme.warningColor; radius: 2 }
                Text {
                    text: "TASK PIPELINE"
                    color: theme.textSec
                    font.pixelSize: 11; font.bold: true; font.letterSpacing: 1.2
                }
                Item { Layout.fillWidth: true }
                Text { text: "0 PENDING"; color: theme.textSec; font.pixelSize: 10; font.bold: true }
            }

            // Empty State / Task List Container
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: theme.inputBg
                radius: 6
                border.color: theme.borderColor

                // Content
                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 16
                    opacity: 0.5 // Dimmed for empty state

                    Rectangle {
                        width: 48; height: 48
                        radius: 24
                        color: "transparent"
                        border.color: theme.textSec
                        border.width: 2
                        Text { anchors.centerIn: parent; text: "+"; color: theme.textSec; font.pixelSize: 24 }
                    }

                    Text {
                        text: "No Active Tasks"
                        color: theme.textSec
                        font.pixelSize: 12
                    }
                }

                // "Add Task" Overlay Button (Bottom Right)
                Button {
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.margins: 12
                    width: 36; height: 36
                    background: Rectangle { color: theme.primaryColor; radius: 18 }
                    contentItem: Text {
                        text: "+"
                        color: "#000"
                        font.pixelSize: 20
                        anchors.centerIn: parent
                    }
                }
            }
        }

        // =========================================
        // SECTION 3: SYSTEM LOGS (30%)
        // =========================================
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 3
            spacing: 12

            // Header
            RowLayout {
                Layout.fillWidth: true
                spacing: 8
                Rectangle { width: 4; height: 16; color: theme.textSec; radius: 2 }
                Text {
                    text: "EVENT LOGS"
                    color: theme.textSec
                    font.pixelSize: 11; font.bold: true; font.letterSpacing: 1.2
                }
            }

            // Log Container
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: theme.inputBg
                radius: 6
                border.color: theme.borderColor

                ListView {
                    anchors.fill: parent
                    anchors.margins: 8
                    clip: true
                    spacing: 4
                    model: ListModel {
                        ListElement { time: "10:48:22"; msg: "Beta_022 Battery Low (<20%)"; type: "warn" }
                        ListElement { time: "10:45:10"; msg: "Lidar Sensor Connected"; type: "info" }
                        ListElement { time: "10:42:05"; msg: "System Boot Sequence Complete"; type: "success" }
                        ListElement { time: "10:42:01"; msg: "Initializing Core Drivers..."; type: "info" }
                    }

                    delegate: Rectangle {
                        width: parent.width
                        height: 24
                        color: "transparent"

                        RowLayout {
                            anchors.fill: parent
                            spacing: 8

                            Text {
                                text: time
                                color: "#555"
                                font.pixelSize: 10
                                font.family: "Monospace"
                            }

                            Rectangle { width: 1; height: 10; color: "#333" }

                            Text {
                                Layout.fillWidth: true
                                text: msg
                                color: type === "warn" ? theme.warningColor : (type === "success" ? theme.successColor : theme.textMain)
                                font.pixelSize: 11
                                elide: Text.ElideRight
                            }
                        }
                    }
                }
            }
        }
    }
}
