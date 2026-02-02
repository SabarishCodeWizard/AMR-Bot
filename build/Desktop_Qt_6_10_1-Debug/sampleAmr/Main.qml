import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: appWindow
    visible: true
    width: 1920
    height: 1080
    title: "TEXSONICS - AMR Fleet Manager"
    color: "#1E1E2E"

    // --- 1. CENTRALIZED THEME OBJECT ---
    // We wrap properties here so we can pass 'appTheme' to other files
    QtObject {
        id: appTheme
        property color primaryColor: "#40C4FF"
        property color accentColor: "#69F0AE"
        property color dangerColor: "#FF5252"
        property color successColor: "#00E676"
        property color warningColor: "#FFAB40"

        property color textMain: "#FFFFFF"
        property color textSec: "#B0BEC5"
        property color panelBg: "#27273A"
        property color inputBg: "#151520"
        property color borderColor: "#3B3B50"
        property color hoverColor: "#32324A"
    }

    // --- 2. MAIN LAYOUT ---
    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // LEFT PANEL
        LeftPanel {
            theme: appTheme // <--- PASSING THE THEME
            Layout.fillHeight: true
            Layout.preferredWidth: 300
            Layout.minimumWidth: 280
            Layout.maximumWidth: 400
        }

        // CENTER PANEL
        CenterPanel {
            theme: appTheme // <--- PASSING THE THEME
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        // RIGHT PANEL
        RightPanel {
            theme: appTheme // <--- PASSING THE THEME
            Layout.fillHeight: true
            Layout.preferredWidth: 300
            Layout.minimumWidth: 280
            Layout.maximumWidth: 400
        }
    }
}
