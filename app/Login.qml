import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls


ColumnLayout{

    signal loginSuccessful
    property alias username: textUser.text
    property alias password: textPassword.text
    property alias statusLogin : statusText.text
    anchors.fill: parent
    Column {
        width: 400
        height: 600
        Layout.alignment: Qt.AlignHCenter
        spacing: 20
        Text {
            text: "Login"
            font.family: "Helvetica"
            font.pointSize: 50
            color: "#000000"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Rectangle{
            width: 400
            height: 300
            color : '#cdf2f2'
            radius : 8
            anchors.horizontalCenter: parent.horizontalCenter
            Column{
                spacing: 50
                anchors.fill: parent
                anchors.leftMargin: 15
                anchors.rightMargin: 15
                anchors.topMargin: 30
                anchors.bottomMargin: 15
                Column{
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 10
                    Rectangle {
                        color: "#cdf2f2"
                        Text {
                            text: "Username"
                            font.family: "Helvetica"
                            font.pointSize: 15
                            color: "#000000"

                        }
                        width: childrenRect.width
                        height: childrenRect.height
                    }
                    TextField {
                        id : textUser
                        width: 300
                        height: 30
                        placeholderText: qsTr("")
                    }
                    Rectangle{
                        color: "#cdf2f2"
                        width: 300
                        height: 10
                    }

                    Row{
                        spacing: 100
                        Rectangle {
                                color: "#cdf2f2"
                            Text {
                                text: "Password"
                                font.family: "Helvetica"
                                font.pointSize: 15
                                color: "#000000"

                            }
                            width: childrenRect.width
                            height: childrenRect.height
                        }

                        MouseArea {
                            width: childrenRect.width
                            height: childrenRect.height
                            onClicked: { forgotPassword.color = 'red' }

                            Text {
                                id : forgotPassword
                                text: "Forgot Password?"
                                font.family: "Helvetica"
                                font.pointSize: 15
                                color: "#4400ff"
                            }
                        }
                    }
                    TextField {
                        id : textPassword
                        width: 300
                        height: 30
                        placeholderText: qsTr("")
                        echoMode: TextInput.Password
                    }
                }

                Rectangle {
                    id : signin
                    color: "#36d556"
                    width: 300
                    height: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    radius : 8
                    MouseArea{
                        anchors.fill: parent
                        onClicked: { loginController.login(username, password) }
                    }
                    Text {
                        id : statusText
                        text: qsTr("Sign in")
                        font.pointSize: 15
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }
    Connections {
        target: loginController
        function onLoginResult(boolValue) {
            if(boolValue){
                statusLogin = "Đăng nhập thành công"
                loginSuccessful()
            }
            else{
                statusLogin = "Đăng nhập thất bại"
            }
            checkLogin = boolValue
        }
    }
}


