import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import Qt.labs.platform

Rectangle {
    id : root
    anchors.fill: parent
    ColumnLayout{
        TextField {
            id : textHost
            width: 300
            height: 30
            placeholderText: qsTr("127.0.0.1")
        }
        TextField {
            id : textPort
            width: 300
            height: 30
            placeholderText: qsTr("3306")
        }
        TextField {
            id : textDatabase
            width: 300
            height: 30
            placeholderText: qsTr("appsolar")
        }
        TextField {
            id : textUser
            width: 300
            height: 30
            placeholderText: qsTr("duyphuoc")
        }
        TextField {
            id : textPassword
            width: 300
            height: 30
            placeholderText: qsTr("bebiu2020")
        }
        Button {
            text: "Connect DataBase"
            onClicked: dataBase.connect_dataBase(textHost.text,textPort.text,textDatabase.text,
                                                 textUser.text,textPassword.text)
            width: 100
            height: 50
        }
    }
}
