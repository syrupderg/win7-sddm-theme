import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Rectangle {
    id: container

    property alias name: name.text
    property alias icon: icon.source

    width: 60
    height: 64

    color: "transparent"

    MouseArea {
        id: containerarea
        anchors.fill: parent
        hoverEnabled: true
    }

    Image {
        id: containerimg

        anchors {
            left: parent.left
            leftMargin: -12
            top: parent.top
            topMargin: -11
        }

        source: {
            if (containerarea.containsMouse && container.focus) return "../Assets/list-hover-focus.png"
            if (containerarea.containsMouse  && !container.focus) return "../Assets/list-hover.png"
            if (!containerarea.containsMouse && container.focus) return "../Assets/list-focus.png"

            return "../Assets/list.png"
        }
    }

    Item {
        id: users
        anchors.left: container.left
        anchors.leftMargin: -7

        Image {
            id: icon
            width: 46
            height: icon.width
            smooth: true
            visible: false

            onStatusChanged: {
                if (icon.status == Image.Error)
                    icon.source = "../Assets/user1.png"
                else
                    "/var/lib/AccountsService/icons/" + name
            }

            x: 12
            y: 5
        }

        OpacityMask {
            id: img
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
            renderType: Text.NativeRendering
            font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
            font.pointSize: 10
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            clip: true
            font.kerning: false

            color: "white"

            anchors {
                horizontalCenter: img.horizontalCenter
                top: img.bottom
                topMargin: 18
            }

            layer.enabled: true
            layer.effect: DropShadow {
                verticalOffset: 1
                horizontalOffset: 1
                color: "black"
                radius: 7
                samples: 20
            }
        }
    }
}
