import QtQuick
import QtQuick.Controls

Button {
    id: loginButton
    hoverEnabled: true
    width: 30
    height: 30
    x: passwordField.width
    y: -5

    background: Image {
        id: loginbuttonBackground
        smooth: false

        source: {
            if (loginButton.pressed) return "../Assets/go-pressed.png"
            if (loginButton.hovered) return "../Assets/go-hover.png"
            return "../Assets/go.png"
        }
    }
}
