import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects


// sabarish

Popup {
    id: keypadRoot
    width: 600
    height: 400
    modal: true
    focus: true
    anchors.centerIn: Overlay.overlay

    // --- THEME PALETTE ---
    readonly property color colBackground: "#1B1B29"
    readonly property color colSurface:    "#252535"
    readonly property color colAccent:     "#40C4FF"
    readonly property color colDisplay:    "#0A0A12"

    // Action Colors
    readonly property color colCrimson:    "#D32F2F"
    readonly property color colForest:     "#388E3C"
    readonly property color colSlate:      "#546E7A"

    property var targetField: null
    property string targetTitle: "INPUT"

    // 0 = Lowercase, 1 = Uppercase, 2 = Symbols
    property int keyboardMode: 0

    enter: Transition { NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 150 } }
    exit: Transition { NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 150 } }

    function openFor(field, title = "ENTER VALUE") {
        targetField = field
        targetTitle = title ? title.toUpperCase() : "INPUT"
        displayInput.text = field.text
        keyboardMode = 0
        keypadRoot.open()
    }

    function handleInput(key) {
        if (key === "SHIFT") { keyboardMode = (keyboardMode === 0) ? 1 : 0; return }
        if (key === "SYM")   { keyboardMode = (keyboardMode === 2) ? 0 : 2; return }
        if (key === "ABC")   { keyboardMode = 0; return }
        if (key === "⌫")     { displayInput.text = displayInput.text.slice(0, -1); return }

        if (key === "OK") {
            if (targetField) targetField.text = displayInput.text
            keypadRoot.close()
            return
        }
        if (key === "CLR")   { displayInput.text = ""; return }
        if (key === "SPACE") { displayInput.text += " "; return }

        displayInput.text += key
        if (keyboardMode === 1) keyboardMode = 0 // Auto-uncaps
    }

    // --- KEYBOARD DATA MODEL ---
    function getKeyLayout() {
        if (keyboardMode === 2) { // SYMBOLS
            return [
                ["1","2","3","4","5","6","7","8","9","0"],
                ["+","-","*","/","=","_","€","$","£","%"],
                ["ABC", "(", ")", "[", "]", "<", ">", "#", "⌫"],
                ["!","?",",","SPACE",".","@"]
            ]
        } else if (keyboardMode === 1) { // UPPERCASE
            return [
                ["Q","W","E","R","T","Y","U","I","O","P"],
                ["A","S","D","F","G","H","J","K","L"],
                ["SHIFT", "Z","X","C","V","B","N","M", "⌫"],
                ["SYM", ",", "SPACE", ".", "!"]
            ]
        } else { // LOWERCASE
            return [
                ["q","w","e","r","t","y","u","i","o","p"],
                ["a","s","d","f","g","h","j","k","l"],
                ["SHIFT", "z","x","c","v","b","n","m", "⌫"],
                ["SYM", ",", "SPACE", ".", "?"]
            ]
        }
    }

    // --- BACKGROUND ---
    background: Item {
        Rectangle {
            id: mainBg
            anchors.fill: parent
            color: colBackground
            radius: 12
            border.color: Qt.lighter(colBackground, 1.5)
            border.width: 1
        }
        MultiEffect {
            source: mainBg
            anchors.fill: mainBg
            shadowEnabled: true
            shadowColor: "black"
            shadowBlur: 1.0
            shadowVerticalOffset: 12
        }
    }

    // --- CONTENT ---
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 5

        // 1. TITLE BAR (Modified: Includes Clear, Apply, Close)
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 42 // Slightly taller for buttons
            color: colSurface
            radius: 8

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 15
                anchors.rightMargin: 6
                spacing: 8

                // Status Dot
                Rectangle {
                    width: 8; height: 8; radius: 4; color: "#00E676"
                    MultiEffect { source: parent; anchors.fill: parent; blurEnabled: true; blur: 0.4 }
                }

                // Title
                Text {
                    text: targetTitle
                    color: colAccent
                    font.pixelSize: 11
                    font.bold: true
                    font.letterSpacing: 1.2
                }

                // Spacer
                Item { Layout.fillWidth: true }

                // --- TOP ACTION BUTTONS ---

                // CLEAR Button
                Button {
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 70
                    background: Rectangle {
                        color: parent.pressed ? Qt.darker(colCrimson) : colCrimson
                        radius: 4
                    }
                    contentItem: Text {
                        text: "CLEAR"
                        color: "white"
                        font.pixelSize: 11
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: handleInput("CLR")
                }

                // APPLY Button
                Button {
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 70
                    background: Rectangle {
                        color: parent.pressed ? Qt.darker(colForest) : colForest
                        radius: 4
                    }
                    contentItem: Text {
                        text: "APPLY"
                        color: "white"
                        font.pixelSize: 11
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: handleInput("OK")
                }

                 // CLOSE Button
                Button {
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 70
                    background: Rectangle {
                        color: parent.pressed ? Qt.darker(colSlate) : colSlate
                        radius: 4
                    }
                    contentItem: Text {
                        text: "CLOSE"
                        color: "white"
                        font.pixelSize: 11
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: keypadRoot.close()
                }
            }
        }

        // 2. DISPLAY AREA
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 70
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                color: colDisplay
                radius: 6
                border.color: "#303040"
                border.width: 1

                TextInput {
                    id: displayInput
                    anchors.fill: parent
                    anchors.margins: 15
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    color: "white"
                    font.pixelSize: 28
                    font.family: "Monospace"
                    font.bold: true
                    text: ""
                    clip: true
                    readOnly: true
                }
            }
        }

        // 3. KEYBOARD AREA
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout {
                anchors.fill: parent
                spacing: 8

                Repeater {
                    model: getKeyLayout()

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 52
                        spacing: 8

                        property var rowKeys: modelData

                        Repeater {
                            model: rowKeys

                            Button {
                                id: keyBtn

                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Layout.preferredWidth: modelData === "SPACE" ? 5 :
                                                       (modelData === "SHIFT" || modelData === "⌫" || modelData === "ABC" || modelData === "SYM") ? 1.5 : 1

                                property bool isAction: (modelData === "SHIFT" || modelData === "⌫" || modelData === "ABC" || modelData === "SYM")
                                property bool isActive: (modelData === "SHIFT" && keyboardMode === 1) || (modelData === "SYM" && keyboardMode === 2)

                                background: Rectangle {
                                    radius: 6
                                    color: keyBtn.pressed ? colAccent :
                                           keyBtn.isActive ? colSlate :
                                           keyBtn.isAction ? colSurface : Qt.darker(colSurface, 0.5)

                                    border.color: keyBtn.pressed || keyBtn.isActive ? "white" : "#353545"
                                    border.width: 1
                                }

                                contentItem: Text {
                                    text: modelData === "SPACE" ? "" : modelData === "SHIFT" ? "⇧" : modelData
                                    color: keyBtn.isActive ? "white" : keyBtn.isAction ? colAccent : "white"
                                    font.pixelSize: keyBtn.isAction ? 16 : 20
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                onClicked: handleInput(modelData)
                            }
                        }
                    }
                }
            }
        }

        // 4. ACTION BAR REMOVED
        // The bottom filler space is gone, allowing the keyboard to use more space
        // or the popup to be more compact.
    }
}
