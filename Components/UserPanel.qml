import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

FocusScope {

    property alias icon: icon.source

    property alias name: name.text

    property alias password: passwordField.text

    property int session: sessionPanel.session

    Connections {
      target: sddm

        function onLoginFailed() {
            truePass.visible = false

            falsePass.visible = true
            falsePass.focus = true
        }

        function onLoginSucceeded() {}
    }

    Image {
        id: containerimg

        width: 193
        height: 194

        z: 5

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: -187
        }

        source: "../Assets/userframe.png"
    }

    Image {
        id: icon
        width: 128
        height: 128
        smooth: true
        visible: false

        onStatusChanged: {
            if (icon.status == Image.Error)
                icon.source = "../Assets/user1.png"
            else
                "/var/lib/AccountsService/icons/" + name
        }

        x: -(icon.width / 2)
        y: -(icon.width * 2) + (icon.width * 0.8)
        z: 4
    }

    OpacityMask {
        id: opacitymask
        visible: true
        anchors.fill: icon
        source: icon
        maskSource: mask
    }

    Item {
        id: mask
        width: icon.width
        height: icon.height
        layer.enabled: true
        visible: false

        Rectangle {
            width: icon.width
            height: icon.height
            color: "black"
        }
    }

    Text {
        id: name
        color: "white"
        font.pointSize: 20
        font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
        renderType: Text.NativeRendering
        font.kerning: false

        z: 4

        anchors {
            topMargin: 32
            horizontalCenter: icon.horizontalCenter
            top: icon.bottom
        }

        layer.enabled: true
        layer.effect: DropShadow {
            verticalOffset: 1
            horizontalOffset: 1
            color: "#99000000"
            radius: 2
            samples: 2
        }
    }

    PasswordField {
        id: passwordField
        x: -115

        anchors {
            topMargin: 8
            top: name.bottom
        }

        Keys.onReturnPressed: {
            truePass.visible = true

            rightPanel.visible = false
            leftPanel.visible = false

            passwordField.visible = false
            passwordField.enabled = false

            opacitymask.visible = false
            name.visible = false

            containerimg.visible = false

            switchUser.visible = false
            switchUser.enabled = false

            sddm.login(model.name, password, session)
        }

        Keys.onEnterPressed: {
            truePass.visible = true

            rightPanel.visible = false
            leftPanel.visible = false

            passwordField.visible = false
            passwordField.enabled = false

            opacitymask.visible = false
            name.visible = false

            containerimg.visible = false

            switchUser.visible = false
            switchUser.enabled = false

            sddm.login(model.name, password, session)
        }

        LoginButton {
            id: loginButton
            visible: true

            x: passwordField.width + 8
            y: -4

            onClicked: {
                truePass.visible = true

                rightPanel.visible = false
                leftPanel.visible = false

                passwordField.visible = false
                passwordField.enabled = false

                opacitymask.visible = false
                name.visible = false

                containerimg.visible = false

                switchUser.visible = false
                switchUser.enabled = false

                sddm.login(model.name, password, session)
            }
        }
    }

    FalsePass {
        id: falsePass
        visible: false

        anchors {
            top: parent.bottom
            topMargin: 50
        }
    }

    TruePass {
        id: truePass
        visible: false

        anchors {
            horizontalCenter: parent.horizontalCenter
            topMargin: -150
            top: name.bottom
        }
    }

    CapsOn {
        id: capsOn
        visible: false

        state: keyboard.capsLock ? "on" : "off"

        states: [
            State {
                name: "on"
                PropertyChanges {
                    target: capsOn
                    visible: true
                }
            },

            State {
                name: "off"
                PropertyChanges {
                    target: capsOn
                    visible: false
                }
            }
        ]

        anchors {
            horizontalCenter: parent.horizontalCenter
            topMargin: 5
            top: passwordField.bottom
        }
    }
}
