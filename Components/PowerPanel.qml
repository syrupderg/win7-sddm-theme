import QtQuick
import QtQuick.Controls

Item {

    Item {
        id: powerButton
        width: 62
        height: 28

        Button {
            id: shutdownButton

            anchors.bottom: parent.bottom
            anchors.left: parent.left

            width: 38
            height: 28

            background: Image {
                source: {
                    if (shutdownButton.pressed) return "../Assets/power-active.png"
                    if (shutdownButton.hovered && shutdownButton.focus) return "../Assets/power-hover-focus.png"
                    if (shutdownButton.hovered && !shutdownButton.focus) return "../Assets/power-hover.png"
                    if (!shutdownButton.hovered && shutdownButton.focus) return "../Assets/power-focus.png"
                    return "../Assets/power.png"
                }
            }

            ToolTip {
                id: shutdownButtonTip

                delay: 1000
                timeout: 4800

                width: 69
                height: 11

                y: shutdownButton.height + 5
                z: 2
                visible: shutdownButton.hovered

                Image {
                    source: "../Assets/shuttip.png"
                }

                background: Rectangle {
                    color: "transparent"
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
                    source: "../Assets/power-glyph.png"
                    smooth: false
                }
            }

            onClicked: {
                sddm.powerOff()
                shutdownButtonTip.hide()
            }
        }

        Button {
            id: expandButton

            anchors.bottom: parent.bottom
            anchors.left: shutdownButton.right

            width: 20
            height: 28

            background: Image {
                source: {
                    if (expandButton.pressed) return "../Assets/expand-active.png"
                    if (expandButton.hovered && expandButton.focus) return "../Assets/expand-hover-focus.png"
                    if (expandButton.hovered && !expandButton.focus) return "../Assets/expand-hover.png"
                    if (!expandButton.hovered && expandButton.focus) return "../Assets/expand-focus.png"
                    return "../Assets/expand.png"
                }
            }

            ToolTip {
                id: expandButtonTip

                delay: 1000
                timeout: 4800

                width: 112
                height: 19

                y: expandButton.height + 5
                z: 2
                visible: expandButton.hovered

                Image {
                    source: "../Assets/moreshuttip.png"
                }

                background: Rectangle {
                    color: "transparent"
                }
            }

            contentItem: Item {
                anchors.centerIn: parent

                width: 9
                height: 6

                Image {
                    anchors.centerIn: parent
                    width: 9
                    height: 6
                    source: "../Assets/expand-glyph-arrow.png"
                    smooth: false
                }
            }

            onClicked: {
                powerPopup.visible ? powerPopup.close() : powerPopup.open()
                powerPopup.visible === powerPopup.open ; powerButton.state = "selection"
                expandButtonTip.hide()
            }
        }
    }

    Popup {
        id: powerPopup
        width: 147
        height: 57
        x: -61
        y: -64
        z: 3

        background: Rectangle {
            color: "transparent"
        }

        Image {
            source:"../Assets/powerlist.png"
        }

        Button {
            id: rebootButton
            width: 141
            height: 22
            hoverEnabled: true

            x: 3
            y: 3

            background: Rectangle {
                id: rebootButtonBackground
                color: "transparent"
            }

            Image {
                source: {
                    if (rebootButton.hovered) return "../Assets/restart-hover.png"
                    return "../Assets/restart.png"
                }
            }

            onClicked: sddm.reboot()
        }

        Button {
            id: poweroffButton
            width: 141
            height: 22
            hoverEnabled: true

            x: 3

            anchors {
                horizontalCenter: rebootButton.horizontalCenter
                top: rebootButton.bottom
                topMargin: 8
            }

            background: Rectangle {
                id: poweroffButtonBackground
                color: "transparent"
            }

            Image {
                source: {
                    if (poweroffButton.hovered) return "../Assets/shutdown-hover.png"
                    return "../Assets/shutdown.png"
                }
            }

            onClicked: sddm.powerOff()
        }

        enter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                easing.type: Easing.OutCirc
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                easing.type: Easing.OutCirc
            }
        }
    }
}
