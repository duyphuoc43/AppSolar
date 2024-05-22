import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
Window {
    id : root
    width: 1920
    height: 1080
    visible: true
    title: qsTr("Solar")
    color : '#ffffff'
    ColumnLayout{
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
                            width: 300
                            height: 30
                            // placeholderText: qsTr("Username")
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
                            width: 300
                            height: 30
                            // placeholderText: qsTr("Password")
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
                            onClicked: { signin.color = "yellow" }
                        }
                        Text {
                            text: qsTr("Sign in")
                            font.pointSize: 15
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
    }
}
