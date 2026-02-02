import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: centerPanelRoot

    // --- RECEIVE THEME ---
    property var theme

    color: "transparent" // Transparent so background shows through gaps

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        // --- HEADER ---
        Rectangle {
            Layout.fillWidth: true
            height: 50
            color: theme.panelBg
            radius: 8
            border.color: theme.borderColor
            Text { anchors.centerIn: parent; text: "TEX STUDIO V0.1"; color: theme.textMain; font.bold: true; font.letterSpacing: 2 }
        }

        // --- MAP VIEWPORT ---
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#0F0F16" // Hardcoded dark map bg
            radius: 8
            border.color: theme.borderColor

            // Grid Lines
            Repeater { model: 20; Rectangle { y: parent.height/20 * index; width: parent.width; height: 1; color: "#222233" } }
            Repeater { model: 20; Rectangle { x: parent.width/20 * index; height: parent.height; width: 1; color: "#222233" } }

            Text { anchors.centerIn: parent; text: "3D SIMULATION VIEW"; color: "#444"; font.pointSize: 20; font.bold: true }

        }

        // --- BOTTOM AMR CONTROLS ---
        Rectangle {
            Layout.fillWidth: true
            height: 200
            color: theme.panelBg
            radius: 8
            border.color: theme.borderColor

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 10

                Text { text: "AMR CONTROL PANEL"; color: theme.textSec; font.bold: true; font.pixelSize: 12 }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 20

                    // Switches
                    ColumnLayout {
                        spacing: 5
                        Repeater {
                            model: ["EtherCAT", "LIDAR", "Drivers", "IMU"]
                            delegate: RowLayout {
                                Text { text: modelData; color: theme.textMain; width: 60; font.pixelSize: 12 }
                                Switch { scale: 0.6; checked: true }
                            }
                        }
                    }

                    // Inputs
                    GridLayout {
                        columns: 2
                        columnSpacing: 10
                        rowSpacing: 10
                        Text { text: "Linear X:"; color: theme.textSec }
                        Rectangle { width: 80; height: 30; color: theme.inputBg; radius: 4; border.color: theme.borderColor }
                        Text { text: "Angular Z:"; color: theme.textSec }
                        Rectangle { width: 80; height: 30; color: theme.inputBg; radius: 4; border.color: theme.borderColor }
                    }

                    Item { Layout.fillWidth: true }

                    // System Status
                    Rectangle {
                        width: 100; height: 80
                        color: theme.successColor
                        radius: 6
                        Column {
                            anchors.centerIn: parent
                            Text { text: "SYSTEM"; font.pixelSize: 10; anchors.horizontalCenter: parent.horizontalCenter }
                            Text { text: "OK"; font.bold: true; font.pixelSize: 24; anchors.horizontalCenter: parent.horizontalCenter }
                        }
                    }
                }
            }
        }
    }
}
