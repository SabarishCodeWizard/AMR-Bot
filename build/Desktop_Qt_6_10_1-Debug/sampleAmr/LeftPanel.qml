import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: leftPanelRoot

    // --- RECEIVE THEME FROM MAIN ---
    property var theme

    color: theme.panelBg
    radius: 8
    border.color: theme.borderColor
    border.width: 1

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 16 // Consistent spacing between the 3 weighted sections

        // =========================================
        // SECTION 1: SYSTEM METRICS (30%)
        // =========================================
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 3 // 30% Weight
            spacing: 10

            // Header
            RowLayout {
                Layout.fillWidth: true
                spacing: 8
                Rectangle { width: 4; height: 16; color: theme.primaryColor; radius: 2 }
                Text {
                    text: "SYSTEM METRICS"
                    color: theme.textSec
                    font.pixelSize: 11; font.bold: true; font.letterSpacing: 1.2
                }
            }

            // Metric Card Container - Fills remaining space in this 30% section
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 0

                    // Distribute metrics evenly within the allocated space
                    Repeater {
                        model: [
                            { label: "Utilization Rate", val: "84%", color: theme.successColor },
                            { label: "AMRs Active", val: "12/15", color: theme.textMain },
                            { label: "Safety Score", val: "99.2", color: theme.primaryColor },
                            { label: "Pending Tasks", val: "04", color: theme.warningColor }
                        ]
                        delegate: Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true // Each item takes equal vertical space

                            RowLayout {
                                anchors.fill: parent
                                Text {
                                    text: modelData.label
                                    color: Qt.rgba(theme.textMain.r, theme.textMain.g, theme.textMain.b, 0.7)
                                    font.pixelSize: 13
                                }
                                Item { Layout.fillWidth: true }
                                Text {
                                    text: modelData.val
                                    color: modelData.color
                                    font.pixelSize: 13; font.bold: true; font.family: "Monospace"
                                }
                            }

                            Rectangle {
                                width: parent.width; height: 1;
                                anchors.bottom: parent.bottom
                                color: theme.borderColor; opacity: 0.3
                                visible: index < 3
                            }
                        }
                    }
                }
            }
        }

        // =========================================
        // SECTION 2: FLEET STATUS (40%)
        // =========================================
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 4 // 40% Weight
            spacing: 10

            // Header
            RowLayout {
                Layout.fillWidth: true
                spacing: 8
                Rectangle { width: 4; height: 16; color: theme.accentColor; radius: 2 }
                Text {
                    text: "FLEET STATUS"
                    color: theme.textSec
                    font.pixelSize: 11; font.bold: true; font.letterSpacing: 1.2
                }
                Item { Layout.fillWidth: true }
                Text { text: "3 ONLINE"; color: theme.successColor; font.pixelSize: 10; font.bold: true }
            }

            // List takes all space inside this 40% section
            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                spacing: 8
                model: ListModel {
                    ListElement { name: "ALPHA_001"; status: "AUTO"; battery: 95; type: "LIFT" }
                    ListElement { name: "BETA_022"; status: "MANUAL"; battery: 65; type: "TUG" }
                    ListElement { name: "GAMMA_300"; status: "ERROR"; battery: 12; type: "LIFT" }
                    ListElement { name: "DELTA_004"; status: "IDLE"; battery: 100; type: "TUG" } // Added item to test scroll
                }

                delegate: Rectangle {
                    width: parent.width
                    height: 60
                    color: theme.inputBg
                    radius: 6
                    border.color: theme.borderColor
                    border.width: 1

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 12

                        // Avatar
                        Rectangle {
                            width: 36; height: 36; radius: 18
                            color: Qt.rgba(theme.primaryColor.r, theme.primaryColor.g, theme.primaryColor.b, 0.15)
                            border.color: theme.primaryColor; border.width: 1
                            Text { anchors.centerIn: parent; text: type.substring(0,1); color: theme.primaryColor; font.bold: true; font.pixelSize: 10 }
                        }

                        // Info
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2
                            RowLayout {
                                Text { text: name; color: theme.textMain; font.bold: true; font.pixelSize: 12 }
                                Item { Layout.fillWidth: true }
                                Text { text: status; font.pixelSize: 9; font.bold: true; color: status === "ERROR" ? theme.dangerColor : theme.successColor }
                            }
                            // Battery
                            Rectangle {
                                Layout.fillWidth: true; height: 3
                                color: "#333"; radius: 2
                                Rectangle { width: parent.width * (battery/100); height: parent.height; radius: 2; color: battery < 20 ? theme.dangerColor : theme.successColor }
                            }
                        }
                    }
                }
            }
        }

        // =========================================
        // SECTION 3: VIEWPORT (30%)
        // =========================================
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 3 // 30% Weight
            spacing: 10

            // Header
            RowLayout {
                Layout.fillWidth: true
                spacing: 8
                Rectangle { width: 4; height: 16; color: theme.textSec; radius: 2 }
                Text {
                    text: "VIEWPORT"
                    color: theme.textSec
                    font.pixelSize: 11; font.bold: true; font.letterSpacing: 1.2
                }
            }

            // Container fills the 30% section
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: theme.inputBg
                radius: 6
                border.color: theme.borderColor

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 0

                    // Items distribute evenly in the 30% height
                    Repeater {
                        model: ["Show LiDAR Cloud", "Camera Follow", "Show Grid", "Show Paths"]
                        delegate: Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            RowLayout {
                                anchors.fill: parent
                                Text { text: modelData; color: theme.textMain; font.pixelSize: 12 }
                                Item { Layout.fillWidth: true }
                                Switch { scale: 0.6; checked: index !== 1 }
                            }
                             // Separator for all except last
                            Rectangle {
                                width: parent.width; height: 1;
                                anchors.bottom: parent.bottom
                                color: theme.borderColor; opacity: 0.3
                                visible: index < 3
                            }
                        }
                    }
                }
            }
        }
    }
}
