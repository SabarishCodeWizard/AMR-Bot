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
        anchors.margins: 15
        spacing: 20

        // --- DASHBOARD SECTION ---
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 10

            Text { text: "DASHBOARD"; color: theme.textSec; font.bold: true; font.pixelSize: 12 }
            Rectangle { Layout.fillWidth: true; height: 1; color: theme.borderColor }

            Repeater {
                model: ["Utilization Rate", "AMRs on Fleet", "Safety Metric", "Task Metric", "Battery Metric"]
                delegate: RowLayout {
                    Layout.fillWidth: true
                    Text { text: modelData; color: theme.textMain; font.pixelSize: 13 }
                    Item { Layout.fillWidth: true }
                    Text { text: "--"; color: theme.primaryColor; font.bold: true }
                }
            }
        }

        // --- ROBOT FLEET LIST ---
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Text { text: "ROBOT FLEET"; color: theme.textSec; font.bold: true; font.pixelSize: 12 }
            Rectangle { Layout.fillWidth: true; height: 1; color: theme.borderColor }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                spacing: 8
                model: ListModel {
                    ListElement { name: "ALPHA_001"; status: "AUTO"; battery: 95 }
                    ListElement { name: "BETA_022"; status: "MANUAL"; battery: 65 }
                    ListElement { name: "GAMMA_300"; status: "ERROR"; battery: 12 }
                }

                delegate: Rectangle {
                    width: parent.width
                    height: 60
                    color: theme.inputBg
                    radius: 6
                    border.color: theme.borderColor

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 10

                        Rectangle {
                            width: 40; height: 40; radius: 4
                            color: theme.primaryColor
                            Text { anchors.centerIn: parent; text: "Bot"; font.pixelSize: 10 }
                        }

                        ColumnLayout {
                            spacing: 4
                            Text { text: name; color: theme.textMain; font.bold: true }
                            Row {
                                spacing: 4
                                Rectangle { width: 40; height: 4; color: "#333"; Rectangle { width: parent.width * (battery/100); height: parent.height; color: battery < 20 ? theme.dangerColor : theme.successColor } }
                                Text { text: battery + "%"; color: theme.textSec; font.pixelSize: 10 }
                            }
                        }
                        Item { Layout.fillWidth: true }
                        Text { text: status; color: status === "ERROR" ? theme.dangerColor : theme.textSec; font.pixelSize: 10; font.bold: true }
                    }
                }
            }
        }

        // --- VIEW CONTROL ---
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 10
            Text { text: "VIEW CONTROL"; color: theme.textSec; font.bold: true; font.pixelSize: 12 }
            Rectangle { Layout.fillWidth: true; height: 1; color: theme.borderColor }

            Repeater {
                model: ["Layer Toggles", "Camera Control", "Grid Settings"]
                delegate: RowLayout {
                    Layout.fillWidth: true
                    Text { text: modelData; color: theme.textMain; font.pixelSize: 13 }
                    Item { Layout.fillWidth: true }
                    Switch { scale: 0.7; checked: true }
                }
            }
        }
    }
}
