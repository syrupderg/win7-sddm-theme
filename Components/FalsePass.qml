import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

FocusScope {
    Image {
        source: "../Assets/dialog-error.png"
        anchors.right: falseText.left
        anchors.rightMargin: 7
        y: -6
    }

    Text {
        id: falseText
        text: "The user name or password is incorrect."
        color: "white"
        font.pointSize: 10
        font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
        renderType: Text.NativeRendering
        x: -100

        layer.enabled: true
        layer.effect: DropShadow {
            verticalOffset: 1
            color: "#000"
            radius: 7
            samples: 20
        }
    }

    Button {
        id: falseButton
        hoverEnabled: true
        width: 92
        height: 27

        x: -45
        y: 70

        Image {
            id: img
            source: {
                if (falseButton.hovered) return "../Assets/ok-hover.png"

                return "../Assets/ok-focus.png"
            }
        }

        onClicked: {
            falsePass.visible = false

            rightPanel.visible = true
            leftPanel.visible = true

            opacitymask.visible = true
            name.visible = true

            containerimg.visible = true

            passwordField.visible = true
            passwordField.enabled = true
            passwordField.focus = true

            switchUser.visible = listView2.count > 1 ? true : false
            switchUser.enabled = listView2.count > 1 ? true : false

            passwordField.text = ""

            capsOn.z = capsOn.state === "on" ? 2 : -1
        }

        Keys.onReturnPressed: {
            falsePass.visible = false

            rightPanel.visible = true
            leftPanel.visible = true

            opacitymask.visible = true
            name.visible = true

            containerimg.visible = true

            passwordField.visible = true
            passwordField.enabled = true
            passwordField.focus = true

            switchUser.visible = listView2.count > 1 ? true : false
            switchUser.enabled = listView2.count > 1 ? true : false

            passwordField.text = ""

            capsOn.z = capsOn.state === "on" ? 2 : -1
        }

        Keys.onEnterPressed: {
            falsePass.visible = false

            rightPanel.visible = true
            leftPanel.visible = true

            opacitymask.visible = true
            name.visible = true

            containerimg.visible = true

            passwordField.visible = true
            passwordField.enabled = true
            passwordField.focus = true

            switchUser.visible = listView2.count > 1 ? true : false
            switchUser.enabled = listView2.count > 1 ? true : false

            passwordField.text = ""

            capsOn.z = capsOn.state === "on" ? 2 : -1
        }
    }
}

