import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import Qt.labs.platform

Rectangle {

    signal back_home()

    id: root
    anchors.fill: parent
    color: "#333333"

    Button{
        anchors.fill: parent
        onClicked: {
            console.error("sssssss")
            console.error(detection.getInformation())
        }
    }
}
