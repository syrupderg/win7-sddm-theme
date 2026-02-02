import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.VirtualKeyboard
import Qt5Compat.GraphicalEffects
import "Components"

Item {
    id: root
    width: Screen.width
    height: Screen.height

    FontLoader {
        id: segoeui
        source: Qt.resolvedUrl("fonts/segoeui.ttf")
    }

    FontLoader {
        id: segoeuil
        source: Qt.resolvedUrl("fonts/segoeuil.ttf")
    }

    Rectangle {
        id: background
        anchors.fill: parent
        width: parent.width
        height: parent.height

        MediaPlayer {
            id: startupSound
            autoPlay: true
            source: Qt.resolvedUrl("Assets/Startup-Sound.wav")
            audioOutput: AudioOutput {}
        }

        Image {
            anchors.fill: parent
            width: parent.width
            height: parent.height
            source: config.background

            Rectangle {
                width: parent.width
                height: parent.height
                color: "transparent"
            }
        }
    }

    Rectangle {
        id: startupPanel
        color: "transparent"
        anchors.fill: parent

        visible: listView2.count > 1 ? true : false
        enabled: listView2.count > 1 ? true : false

        Component {
            id: userDelegate2

            UserList {
                id: userList
                name: (model.realName === "") ? model.name : model.realName
                icon: "/var/lib/AccountsService/icons/" + model.name

                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        listView2.currentIndex = index
                        listView2.focus = true
                        listView.currentIndex = index
                        listView.focus = true
                        centerPanel.visible = true
                        centerPanel.enabled = true
                        startupPanel.visible = false
                        startupPanel.enabled = false
                    }
                }
            }
        }

        Rectangle {
            //width: user 60 + spacing 120 + user 60 + spacing 120 + user 60
            width: 180 * listView2.count
            height: 125
            color: "transparent"
            clip: true

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            Item {
                id: usersContainer2
                width: parent.width
                height: parent.height

                Button {
                    id: prevUser2
                    visible: false
                    enabled: false
                    width: 60

                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                    }
                }

                ListView {
                    id: listView2
                    height: parent.height
                    focus: true
                    model: userModel
                    currentIndex: userModel.lastIndex
                    delegate: userDelegate2
                    orientation: ListView.Horizontal
                    interactive: false
                    spacing: 120

                    anchors {
                        left: prevUser2.right
                        right: nextUser2.left
                    }
                }

                Button {
                    id: nextUser2
                    visible: true
                    width: 0
                    enabled: false

                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                    }
                }
            }
        }
    }

    Item {
        id: centerPanel
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: root.width / 1.75
        visible: listView2.count > 1 ? false : true
        enabled: listView2.count > 1 ? false : true
        z: 1

        Item {
            Item {
                id: keyboardContainer
                parent: root
                z: 100

                width: Screen.width / 2
                height: inputPanel.height

                x: (Screen.width - width) / 2
                y: (Screen.height / 2) + 150

                Rectangle {
                    id: dragBar
                    height: 30
                    width: parent.width
                    color: "transparent"

                    anchors.bottom: inputPanel.top
                    anchors.bottomMargin: 0

                    state: "off"

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.SizeAllCursor

                        drag.target: keyboardContainer
                        drag.axis: Drag.XAndYAxis
                        drag.minimumX: -Screen.width
                        drag.maximumX: Screen.width
                        drag.minimumY: -Screen.height
                        drag.maximumY: Screen.height
                    }

                    Image {
                        source: "Assets/oskbg.png"
                    }

                    Image {
                        source: "Assets/osk.png"
                        width: 17
                        height: 17
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.top: parent.top
                        anchors.topMargin: 8
                    }

                    Text {
                        text: "On-Screen Keyboard"
                        anchors.left: parent.left
                        anchors.leftMargin: 35
                        anchors.verticalCenter: parent.verticalCenter
                        color: "black"
                        font.pointSize: 9
                        font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
                        renderType: Text.NativeRendering
                    }

                    Button {
                        id: closeosk
                        width: 31
                        height: 16
                        hoverEnabled: true
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.topMargin: 8

                        Image {
                            source: closeosk.hovered ? "Assets/close-hover.png" : "Assets/close.png"
                        }

                        onClicked: {
                            sessionPanel.savedKeyboardState = "off"
                            if (typeof keyboardText !== "undefined") {
                                keyboardText.text = "off"
                            }
                        }
                    }

                    Button {
                        id: maxosk
                        width: 31
                        height: 16
                        hoverEnabled: true
                        anchors.right: closeosk.left
                        anchors.rightMargin: 3
                        anchors.top: parent.top
                        anchors.topMargin: 8

                        Image {
                            source: "Assets/max.png"
                            width: 30
                            height: 17
                        }
                    }

                    Button {
                        id: minosk
                        width: 31
                        height: 16
                        hoverEnabled: true
                        anchors.right: maxosk.left
                        anchors.rightMargin: 3
                        anchors.top: parent.top
                        anchors.topMargin: 8

                        Image {
                            source: "Assets/min.png"
                            width: 30
                            height: 17
                        }

                        onClicked: {
                            sessionPanel.savedKeyboardState = "off"
                            if (typeof keyboardText !== "undefined") {
                                keyboardText.text = "off"
                            }
                        }
                    }

                    states: [
                        State {
                            name: "on"
                            when: sessionText.text  === "on"
                            PropertyChanges { target: dragBar; visible: true; enabled: true }
                        },
                        State {
                            name: "off"
                            when: sessionText.text  === "off"
                            PropertyChanges { target: dragBar; visible: false; enabled: false }
                        }
                    ]
                }

                InputPanel {
                    id: inputPanel
                    width: parent.width
                    x: 8

                    states: [
                        State {
                            name: "on"
                            when: sessionText.text === "on"
                            PropertyChanges { target: inputPanel; visible: true; enabled: true }
                        },
                        State {
                            name: "off"
                            when: sessionText.text === "off"
                            PropertyChanges { target: inputPanel; visible: false; enabled: false }
                        }
                    ]
                }
            }

            Component {
                id: userDelegate

                FocusScope {
                    anchors.centerIn: parent
                    name: (model.realName === "") ? model.name : model.realName
                    icon: "/var/lib/AccountsService/icons/" + model.name

                    property alias icon: icon.source
                    property alias name: name.text
                    property alias password: passwordField.text
                    property int session: sessionPanel.session

                    visible: ListView.isCurrentItem
                    enabled: ListView.isCurrentItem
                    height: 0
                    width: 296

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
                        anchors {
                            left: parent.left
                            leftMargin: -85
                            top: parent.top
                            topMargin: -187
                        }
                        source: "Assets/userframe.png"
                    }

                    Image {
                        id: icon
                        width: 128
                        height: 128
                        smooth: true
                        visible: false
                        onStatusChanged: {
                            if (icon.status == Image.Error) icon.source = "Assets/user1.png"
                            else "/var/lib/AccountsService/icons/" + name
                        }
                        x: -(icon.width / 2) + 12
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
                        anchors {
                            horizontalCenter: icon.horizontalCenter
                            top: icon.bottom
                            topMargin: 32
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
                        x: -98
                        anchors {
                            topMargin: 9
                            top: name.bottom
                        }

                        Keys.onReturnPressed: {
                            truePass.visible = true
                            keyboardText.text = "off"
                            sessionPanel.savedKeyboardState = keyboardText.text
                            rightPanel.visible = false
                            leftPanel.visible = false
                            passwordField.visible = false
                            passwordField.enabled = false
                            opacitymask.visible = false
                            name.visible = false
                            containerimg.visible = false
                            switchUser.visible = false
                            switchUser.enabled = false
                            capsOn.z = -1
                            sddm.login(model.name, password, session)
                        }

                        Keys.onEnterPressed: {
                            truePass.visible = true
                            keyboardText.text = "off"
                            sessionPanel.savedKeyboardState = keyboardText.text
                            rightPanel.visible = false
                            leftPanel.visible = false
                            passwordField.visible = false
                            passwordField.enabled = false
                            opacitymask.visible = false
                            name.visible = false
                            containerimg.visible = false
                            switchUser.visible = false
                            switchUser.enabled = false
                            capsOn.z = -1
                            sddm.login(model.name, password, session)
                        }

                        LoginButton {
                            id: loginButton
                            visible: true
                            x: passwordField.width + 8
                            y: -4
                            onClicked: {
                                truePass.visible = true
                                keyboardText.text = "off"
                                sessionPanel.savedKeyboardState = keyboardText.text
                                rightPanel.visible = false
                                leftPanel.visible = false
                                passwordField.visible = false
                                passwordField.enabled = false
                                opacitymask.visible = false
                                name.visible = false
                                containerimg.visible = false
                                switchUser.visible = false
                                switchUser.enabled = false
                                capsOn.z = -1
                                sddm.login(model.name, password, session)
                            }
                        }
                    }

                    FalsePass {
                        id: falsePass
                        visible: false
                        anchors {
                            top: icon.bottom
                            topMargin: 50
                        }
                    }

                    TruePass {
                        id: truePass
                        visible: false
                        anchors {
                            left: parent.left
                            leftMargin: 25
                            topMargin: -150
                            top: name.bottom
                        }
                    }

                    CapsOn {
                        id: capsOn
                        visible: false
                        z: 2
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
                                    z: -1
                                }
                            }
                        ]
                        anchors {
                            horizontalCenter: icon.horizontalCenter
                            topMargin: 5
                            top: passwordField.bottom
                        }
                    }
                }
            }

            Button {
                id: prevUser
                anchors.left: parent.left
                enabled: false
                visible: false
            }

            ListView {
                id: listView
                focus: listView.count > 1 ? false : true
                model: userModel
                delegate: userDelegate
                currentIndex: userModel.lastIndex
                interactive: false
                anchors {
                    left: prevUser.right
                    right: nextUser.left
                }
            }

            Button {
                id: nextUser
                anchors.right: parent.right
                enabled: false
                visible: false
            }
        }

        Button {
            id: switchUser
            width: 108
            height: 27
            hoverEnabled: true
            visible: listView2.count > 1 ? true : false
            enabled: listView2.count > 1 ? true : false
            onClicked: {
                centerPanel.visible = false
                centerPanel.enabled = false
                startupPanel.visible = true
                startupPanel.enabled = true
            }
            anchors {
                left: parent.left
                leftMargin: -191
                top: parent.bottom
                topMargin: 150
            }
            Text {
                text: "Switch user"
                font.pointSize: 11.5
                font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
                renderType: Text.NativeRendering
                color: "white"
                anchors.centerIn: parent
            }
            background: Rectangle {
                id: switchUserbg
                color: "transparent"
                Image {
                    id: switchImg
                    source: {
                        if (switchUser.pressed) return "Assets/switch-user-button-active.png"
                        if (switchUser.hovered && switchUser.focus) return "Assets/switch-user-button-hover-focus.png"
                        if (switchUser.hovered && !switchUser.focus) return "Assets/switch-user-button-hover.png"
                        if (!switchUser.hovered && switchUser.focus) return "Assets/switch-user-button-focus.png"
                        return "Assets/switch-user-button.png"
                    }
                }
            }
        }
    }

    Image {
        source: config.branding
        z: 2

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
        id: rightPanel
        z: 2

        anchors {
            bottom: parent.bottom
            right: parent.right
            rightMargin: 92
            bottomMargin: 62
        }

        PowerPanel {
            id: powerPanel
        }
    }

    Item {
        id: leftPanel
        z: 2

        anchors {
            bottom: parent.bottom
            left: parent.left
            leftMargin: 34
            bottomMargin: 62
        }

        Item {
            id: sessionPanel

            property int savedSessionIndex: sessionModel.lastIndex
            property string savedKeyboardState: "off"
            property int session: savedSessionIndex

            implicitHeight: sessionButton.height
            implicitWidth: sessionButton.width

            Text {
                id: sessionText
                text: sessionPanel.savedKeyboardState
                visible: false
            }

            DelegateModel {
                id: sessionWrapper
                model: sessionModel
                delegate: ItemDelegate {

                    id: sessionEntry
                    width: parent.width
                    height: 25
                    highlighted: sessionList.currentIndex == index

                    contentItem: Text {
                        renderType: Text.CurveRendering
                        renderTypeQuality: Text.LowRenderTypeQuality
                        font.weight: Font.Normal
                        font.family: Qt.resolvedUrl("fonts/segoeui.ttf")
                        font.pointSize: 10.4
                        verticalAlignment: Text.AlignVCenter
                        color: "black"
                        text: name
                        leftPadding: 24

                        Button {
                            id: checkPool
                            width: 13
                            height: 13
                            z: 3
                            hoverEnabled: true

                            anchors {
                                right: parent.left
                                rightMargin: -20
                            }

                            Image {
                                id: cimg
                                source: {
                                    if (checkbox.hovered && sessionEntry.focus) return "Assets/cbox-hover-focus.png"
                                    if (checkbox.hovered && !sessionEntry.focus) return "Assets/cbox-hover.png"
                                    if (!checkbox.hovered && sessionEntry.focus) return "Assets/cbox-focus.png"
                                    return "Assets/cbox.png"
                                }
                            }

                            Button {
                                id: checkbox
                                width: 13
                                height: 13
                                hoverEnabled: true
                                background: Rectangle { color: "transparent" }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        sessionList.currentIndex = index
                                    }
                                }
                            }
                        }
                    }

                    background: Rectangle {
                        id: sessionEntryBackground
                        color: "white"
                    }
                }
            }

            Button {
                id: sessionButton
                width: 38
                height: 28
                hoverEnabled: true
                background: Image {
                    id: sessionButtonBackground

                    source: {
                        if (sessionButton.pressed) return "Assets/access-button-active.png"
                        if (sessionButton.hovered && sessionButton.focus) return "Assets/access-button-hover-focus.png"
                        if (sessionButton.hovered && !sessionButton.focus) return "Assets/access-button-hover.png"
                        if (!sessionButton.hovered && sessionButton.focus) return "Assets/access-button-focus.png"
                        return "Assets/access-button.png"
                    }
                }

                contentItem: Item {
                    anchors.centerIn: parent
                    width: 24
                    height: 24

                    Image {
                        anchors.centerIn: parent
                        width: 24
                        height: 24
                        source: "Assets/12213.png"
                        smooth: false
                    }
                }

                ToolTip {
                    id: sessionButtonTip
                    delay: 1000
                    timeout: 4800
                    leftPadding: 9
                    rightPadding: 9
                    topPadding: 7
                    bottomPadding: 7
                    y: sessionButton.height + 5
                    z: 2
                    visible: sessionButton.hovered
                    contentItem: Text {
                        text: "Session"
                        font.family: Qt.resolvedUrl("fonts/segoeui.ttf")
                        renderType: Text.NativeRendering
                        color: "white"
                    }

                    background: Rectangle {
                        color: "#2A2A2A"
                        border.width: 1
                        border.color: "#1A1A1A"
                    }
                }

                onClicked: {
                    session.visible ? session.visible = false : session.visible = true
                    sessionButtonTip.hide()
                }
            }

            Rectangle {
                id: session
                width: 506
                height: 407
                radius: 8
                visible: false
                y: -550
                z: 2

                Drag.active: dragArea.drag.active
                Drag.hotSpot.x: 10
                Drag.hotSpot.y: 10

                onVisibleChanged: {
                    if (visible) {
                        sessionList.currentIndex = sessionPanel.savedSessionIndex
                        keyboardText.text = sessionPanel.savedKeyboardState
                    }
                }

                Image {
                    source: "Assets/sessions.png"
                }

                Control {
                    id: sessionPopup
                    width: 500
                    height: 250
                    z: 1
                    leftInset: 50
                    leftPadding: 50
                    rightInset: 50
                    rightPadding: 50
                    bottomPadding: 5
                    bottomInset: 5
                    background: Rectangle { color: "white" }
                    anchors.top: parent.top
                    anchors.topMargin: 91

                    contentItem: ListView {
                        id: sessionList
                        implicitHeight: contentHeight
                        model: sessionWrapper
                        currentIndex: -1
                        clip: true
                        spacing: 20
                        interactive: sessionList.count > 6 ? true : false
                    }

                    Button  {
                        id: screenKeyboard
                        width: 500
                        height: 250
                        z: 3
                        leftInset: 50; leftPadding: 50
                        rightInset: 50; rightPadding: 50
                        bottomPadding: 5; bottomInset: 5
                        anchors.top: parent.top
                        anchors.topMargin: -75
                        visible: true
                        enabled: true

                        Button {
                            id: kbCheckbox
                            width: 13
                            height: 13
                            z: 3
                            hoverEnabled: true

                            anchors {
                                left: parent.left
                                leftMargin: 63
                                verticalCenter: parent.verticalCenter
                            }

                            Image {
                                id: kbCheckImg
                                anchors.centerIn: parent
                                source: {
                                    var isOn = (keyboardText.text === "on");
                                    if (kbCheckbox.hovered && isOn) return "Assets/cbox-hover-focus.png"
                                    if (kbCheckbox.hovered && !isOn) return "Assets/cbox-hover.png"
                                    if (!kbCheckbox.hovered && isOn) return "Assets/cbox-focus.png"
                                    return "Assets/cbox.png"
                                }
                            }

                            background: Rectangle { color: "transparent" }
                            onClicked: {
                                if (keyboardText.text === "off") keyboardText.text = "on"
                                else keyboardText.text = "off"
                            }
                        }

                        Image {
                            id: osk
                            source: "Assets/osk.png"
                            width: 29
                            height: 29
                            anchors {
                               left: parent.left
                               leftMargin: 29
                               verticalCenter: parent.verticalCenter
                           }
                        }

                        Text {
                            color: "black"
                            text: "Type without the keyboard (On-Screen Keyboard)"
                            renderType: Text.NativeRendering
                            font.family: Qt.resolvedUrl("fonts/segoeui.ttf")
                            font.pointSize: 10.4
                            anchors {
                                verticalCenter: parent.verticalCenter
                                left: kbCheckbox.right
                                leftMargin: 5
                            }
                        }

                        Text {
                            id: keyboardText
                            color: "transparent"
                            text: "off"
                            visible: false
                        }

                        states: [
                            State {
                                name: "on"
                                PropertyChanges { target: keyboardText; text: "on" }
                            },
                            State {
                                name: "off"
                                PropertyChanges { target: keyboardText; text: "off" }
                            }
                        ]

                        background: Rectangle {
                            id: screenKeyboardBackground
                            color: "transparent"
                        }
                    }
                }

                Item {
                    id: titleBar
                    width: parent.width
                    height: 30
                    anchors.top: parent.top
                    z: 5

                    MouseArea {
                        id: dragArea
                        anchors.fill: parent
                        drag.target: session
                        cursorShape: Qt.SizeAllCursor

                        z: -1
                    }

                    Button {
                        id: closebut
                        width: 31
                        height: 16
                        hoverEnabled: true
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.top: parent.top
                        anchors.topMargin: 8

                        Image {
                            source: closebut.hovered ? "Assets/close-hover.png" : "Assets/close.png"
                        }

                        onClicked: {
                            sessionList.currentIndex = sessionPanel.savedSessionIndex
                            keyboardText.text = sessionPanel.savedKeyboardState
                            session.visible = false
                        }
                    }
                }

                Button {
                    id: apbut
                    width: 73
                    height: 20
                    hoverEnabled: true
                    enabled: (sessionList.currentIndex !== sessionPanel.savedSessionIndex) || (keyboardText.text !== sessionPanel.savedKeyboardState)
                    opacity: enabled ? 1.0 : 0.6
                    anchors.right: parent.right
                    anchors.rightMargin: 19
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 19

                    Image {
                        source: apbut.hovered ? "Assets/apbutton-hover.png" : "Assets/apbutton.png"
                    }

                    onClicked: {
                        sessionPanel.savedSessionIndex = sessionList.currentIndex
                        sessionPanel.savedKeyboardState = keyboardText.text
                    }
                }

                Button {
                    id: canbut
                    width: 73
                    height: 20
                    hoverEnabled: true
                    anchors.right: apbut.left
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 19

                    Image {
                        source: canbut.hovered ? "Assets/canbutton-hover.png" : "Assets/canbutton.png"
                    }

                    onClicked: {
                        sessionList.currentIndex = sessionPanel.savedSessionIndex
                        keyboardText.text = sessionPanel.savedKeyboardState
                        session.visible = false
                    }
                }

                Button {
                    id: okbut
                    width: 73
                    height: 20
                    hoverEnabled: true
                    anchors.right: canbut.left
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 19

                    Image {
                        source: okbut.hovered ? "Assets/okbutton-hover.png" : "Assets/okbutton.png"
                    }

                    onClicked: {
                        sessionPanel.savedSessionIndex = sessionList.currentIndex
                        sessionPanel.savedKeyboardState = keyboardText.text
                        session.visible = false
                    }
                }
            }
        }
    }
}
