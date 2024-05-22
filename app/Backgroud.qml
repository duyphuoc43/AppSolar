import QtQuick

Rectangle {
    anchors.fill: parent
    Image {
        id : imageBackgroud
        source: "home.jpeg"
        fillMode: Image.Stretch
        anchors.fill: parent
        opacity: 0.9
    }
}
