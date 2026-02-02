import QtQuick
import QtQuick.Controls

TextField {
    id: passwordField
    focus: true
    visible: true
    selectByMouse: true

    property alias text: passwordField.text

    echoMode: TextInput.Password
    selectionColor: "#3399FF"

    font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
    font.pointSize: 9.2
    renderType: Text.NativeRendering

    color: "black"

    horizontalAlignment: TextInput.AlignLeft
    width: 217
    height: 24

    onTextChanged: {
        if (passwordField.length > 0) {
            passFieldBackground.source = "../Assets/input-type.png"
        }

        if (passwordField.length < 1) {
            passFieldBackground.source = "../Assets/input.png"
        }
    }

    background: Image {
        id: passFieldBackground
        x: -3
        smooth: false
        width: 224

        source: "../Assets/input.png"
    }
}
