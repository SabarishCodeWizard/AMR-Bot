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
        anchors.margins: 15
        spacing: 20

        // --- CONTROL CENTER ---
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 15

            Text { text: "CONTROL CENTER"; color: theme.textSec; font.bold: true; font.pixelSize: 12 }
            Rectangle { Layout.fillWidth: true; height: 1; color: theme.borderColor }

            Rectangle {
                Layout.fillWidth: true
                height: 50
                color: theme.inputBg
                radius: 6
                RowLayout {
                    anchors.fill: parent; anchors.margins: 10
                    Text { text: "MODE:"; color: theme.textSec }
                    Text { text: "AUTOMATIC"; color: theme.primaryColor; font.bold: true }
                    Item { Layout.fillWidth: true }
                    Switch { scale: 0.8; checked: true }
                }
            }

            Button {
                Layout.fillWidth: true
                height: 50
                background: Rectangle { color: theme.dangerColor; radius: 6 }
                contentItem: Text { text: "EMERGENCY STOP"; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            }
        }

        // --- TASK CONTROL ---
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Text { text: "TASK QUEUE"; color: theme.textSec; font.bold: true; font.pixelSize: 12 }
            Rectangle { Layout.fillWidth: true; height: 1; color: theme.borderColor }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: theme.inputBg
                radius: 6
                border.color: theme.borderColor

                Column {
                    anchors.centerIn: parent
                    spacing: 10
                    Text { text: "No Active Tasks"; color: theme.textSec; anchors.horizontalCenter: parent.horizontalCenter }
                    Button {
                        text: "+ New Task"
                        background: Rectangle { color: "transparent"; border.color: theme.primaryColor; radius: 4 }
                        contentItem: Text { text: parent.text; color: theme.primaryColor; padding: 5 }
                    }
                }
            }
        }

        // --- LOGS ---
        ColumnLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 150
            spacing: 10

            Text { text: "SYSTEM LOGS"; color: theme.textSec; font.bold: true; font.pixelSize: 12 }
            Rectangle { Layout.fillWidth: true; height: 1; color: theme.borderColor }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                model: ListModel {
                    ListElement { time: "10:42"; msg: "System Started"; type: "info" }
                    ListElement { time: "10:45"; msg: "Lidar Connected"; type: "info" }
                    ListElement { time: "10:48"; msg: "Beta_022 Low Batt"; type: "warn" }
                }
                delegate: RowLayout {
                    width: parent.width
                    spacing: 10
                    Text { text: time; color: "#666"; font.pixelSize: 11 }
                    Text { text: msg; color: type === "warn" ? theme.warningColor : theme.textMain; font.pixelSize: 11 }
                }
            }
        }
    }
}
