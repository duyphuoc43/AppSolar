import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import Qt.labs.platform

Rectangle {

    signal buttonClicked()

    id: root
    anchors.fill: parent
    color: "transparent"
    radius : 10
    Rectangle{
        border.width : 5
        border.color : "#000000"
        color: "#f0f0f0"
        radius : 10
    }
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10
        TextField {
            id: textHost
            Layout.fillWidth: true
            placeholderText: qsTr("Host (e.g., 127.0.0.1)")
            font.pixelSize: 16
            height: 40
            background: Rectangle {
                color: "white"
                radius: 5
                border.color: "lightgrey"
                border.width: 1
            }
        }
        TextField {
            id: textPort
            Layout.fillWidth: true
            placeholderText: qsTr("Port (e.g., 3306)")
            font.pixelSize: 16
            height: 40
            background: Rectangle {
                color: "white"
                radius: 5
                border.color: "lightgrey"
                border.width: 1
            }
        }

        TextField {
            id: textDatabase
            Layout.fillWidth: true
            placeholderText: qsTr("Database name")
            font.pixelSize: 16
            height: 40
            background: Rectangle {
                color: "white"
                radius: 5
                border.color: "lightgrey"
                border.width: 1
            }
        }

        TextField {
            id: textUser
            Layout.fillWidth: true
            placeholderText: qsTr("Username")
            font.pixelSize: 16
            height: 40
            background: Rectangle {
                color: "white"
                radius: 5
                border.color: "lightgrey"
                border.width: 1
            }
        }

        TextField {
            id: textPassword
            Layout.fillWidth: true
            placeholderText: qsTr("Password")
            font.pixelSize: 16
            height: 40
            background: Rectangle {
                color: "white"
                radius: 5
                border.color: "lightgrey"
                border.width: 1
            }
        }

        Button {
            text: "Connect to Database"
            Layout.alignment: Qt.AlignHCenter
            width: 200
            height: 50
            font.pixelSize: 16
            background: Rectangle {
                color: "#6ab4e3"
                radius: 5
                border.color: "#6ab4e3"
                border.width: 1
            }
            onClicked: {
                db.connectDataBase(textHost.text, textPort.text, textDatabase.text,
                                            textUser.text, textPassword.text)
                buttonClicked(textHost.text, textPort.text, textDatabase.text,
                                            textUser.text)
            }
        }
    }
}
