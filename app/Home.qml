import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
Rectangle {
    anchors.fill: parent
    Image {
        id : imageBackgroud
        source: "../data/home.png"
        fillMode: Image.Stretch
        anchors.fill: parent
        opacity: 0.9
        RowLayout{
            anchors.fill: parent
            Column{
                width: 100
                height: 800
                Layout.leftMargin: 30
                Rectangle{
                    anchors.fill: parent
                    color : "#240436"
                    radius: 10
                }
            }
        }
    }
}
