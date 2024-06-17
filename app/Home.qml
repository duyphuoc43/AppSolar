import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
Rectangle {
    signal contactprofile
    signal contactdataBase
    signal contactcoutersolar
    signal contactdetection
    signal contactlogout
    anchors.fill: parent
    Image {
        id : imageBackgroud
        source: "../data/epc.jpg"
        fillMode: Image.Stretch
        anchors.fill: parent
        opacity: 0.8
        RowLayout{
            anchors.fill: parent
            anchors.centerIn: parent
            ColumnLayout{
                width: 100
                height: 800
                Layout.leftMargin: 50
                Rectangle{
                    width: 100
                    height: 800
                    color : "#9943ca"
                    radius: 10
                    Column{
                        spacing: 50
                        anchors.centerIn: parent
                        Button {
                           text: "Profile"
                           width: 80
                           height: 80
                           anchors.horizontalCenter: parent.horizontalCenter
                           // font.pixelSize: 24
                           onClicked: contactprofile()

                        }
                        Button {
                           text: "DataBase"
                           width: 80
                           height: 80
                           anchors.horizontalCenter: parent.horizontalCenter
                           // font.pixelSize: 24
                           onClicked: contactdataBase()
                        }
                        Button {
                           text: "Couter Solar"
                           width: 80
                           height: 80
                           anchors.horizontalCenter: parent.horizontalCenter
                           // font.pixelSize: 24
                           onClicked: contactcoutersolar()
                        }
                        Button {
                           text: "Detection"
                           width: 80
                           height: 80
                           anchors.horizontalCenter: parent.horizontalCenter
                           // font.pixelSize: 24
                           onClicked: contactdetection()
                        }
                        Button {
                           text: "Logout"
                           width: 80
                           height: 80
                           anchors.horizontalCenter: parent.horizontalCenter
                           // font.pixelSize: 24
                           onClicked: contactlogout()
                        }
                    }
                }
            }
            Rectangle{
                width: 1700
                height: 800
                color : "#f7f8f8"
                border.color: "black"
                border.width: 5
                radius : 8
                ColumnLayout{
                    anchors.centerIn: parent
                    Rectangle{
                        width: 1600
                        height: 400
                        color : "transparent"
                        border.color: "black"
                        border.width: 5
                        radius : 20
                        Row{
                            anchors.centerIn: parent
                            Rectangle{
                                width: 790
                                height: 380
                                color : "#6c63e9"
                                border.color: "transparent"
                                border.width: 5
                                radius : 20

                                Column{
                                    anchors.centerIn: parent
                                    Rectangle{
                                        id : profile
                                        width: 760
                                        height: 80
                                        radius : 20
                                        color: "yellow"
                                        Row{
                                            Column{
                                                Text {
                                                    id: info
                                                    text: qsTr("Name : Duy Phước")
                                                }
                                                Text {
                                                    id: position
                                                    text: qsTr("Name : Engineer")
                                                }
                                            }
                                            Image {
                                                id: imagePerson
                                                source: "file"
                                            }
                                        }
                                    }
                                    Rectangle{
                                        width: 760
                                        height: 280
                                        color : "transparent"
                                        Row{
                                            anchors.centerIn: parent
                                            spacing: 20
                                            Rectangle{
                                                id : checkGPUandCPU
                                                width: 370
                                                height: 260
                                                color : "#65ebf0"
                                                radius : 20
                                                Text {
                                                    text: "Thông tin CPU"
                                                    anchors.centerIn: parent
                                                }
                                                Text {
                                                    text: "Thông tin GPU"
                                                    anchors.centerIn: parent
                                                }
                                            }
                                            Rectangle{
                                                id : checkDataBase
                                                width: 370
                                                height: 260
                                                color : "#65ebf0"
                                                radius : 20
                                                Text {
                                                    text: "Thông tin DataBase"
                                                    anchors.centerIn: parent
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Rectangle{
                                width: 790
                                height: 380
                                color : "transparent"
                                GridLayout {
                                    columnSpacing: 50
                                    rowSpacing: 50
                                    anchors.centerIn: parent
                                    columns: 2
                                    rows: 2

                                    Rectangle {
                                        Layout.columnSpan: 1
                                        Layout.rowSpan: 1
                                        width: 300
                                        height: 150
                                        color: "#65ebf0"
                                        radius : 20
                                        Text {
                                            text: "Kết nối DataBase"
                                            anchors.centerIn: parent
                                        }
                                    }

                                    Rectangle {
                                        Layout.columnSpan: 1
                                        Layout.rowSpan: 1
                                        width: 300
                                        height: 150
                                        color: "#65ebf0"
                                        radius : 20
                                        Text {
                                            text: "Tạo Account"
                                            anchors.centerIn: parent
                                        }
                                    }

                                    Rectangle {
                                        Layout.columnSpan: 1
                                        Layout.rowSpan: 1
                                        width: 300
                                        height: 150
                                        color: "#65ebf0"
                                        radius : 20
                                        Text {
                                            text: "Kiểm tra kết nối mạng"
                                            anchors.centerIn: parent
                                        }
                                    }
                                    Rectangle {
                                        Layout.columnSpan: 1
                                        Layout.rowSpan: 1
                                        width: 300
                                        height: 150
                                        color: "#65ebf0"
                                        radius : 20
                                        Text {
                                            text: "Lịch sử"
                                            anchors.centerIn: parent
                                        }

                                    }
                                }
                            }
                        }

                    }
                    Rectangle{
                        width: 1600
                        height: 300
                        color : "transparent"
                        radius : 20
                        RowLayout{
                            anchors.centerIn: parent
                            spacing: 134
                            Rectangle{
                                width: 300
                                height: 300
                                color : "#65ebf0"
                                border.color: "transparent"
                                border.width: 5
                                radius : 20
                                Rectangle{
                                    width: 150
                                    height: 150
                                    anchors.centerIn: parent
                                    radius : 100
                                    color : "green"
                                    border.color: "yellow"
                                    border.width: 5
                                }

                            }
                            Rectangle{
                                width: 300
                                height: 300
                                color : "#65ebf0"
                                border.color: "transparent"
                                border.width: 5
                                radius : 20
                                Rectangle{
                                    width: 150
                                    height: 150
                                    anchors.centerIn: parent
                                    radius : 100
                                    color : "#ffffff"
                                    MouseArea{
                                        anchors.fill: parent
                                        Text {
                                            text: "LOCK"
                                            anchors.centerIn: parent
                                        }
                                    }
                                }
                            }
                            Rectangle{
                                width: 300
                                height: 300
                                color :"#65ebf0"
                                border.color: "transparent"
                                border.width: 5
                                radius : 20
                                Text {
                                    text: "24"
                                    anchors.centerIn: parent
                                }
                            }
                            Rectangle{
                                width: 300
                                height: 300
                                color : "#65ebf0"
                                border.color: "transparent"
                                border.width: 5
                                radius : 20
                                Rectangle{
                                    width: 150
                                    height: 150
                                    anchors.centerIn: parent
                                    radius : 100
                                    color : "#ffffff"
                                    MouseArea{
                                        anchors.fill: parent
                                        Text {
                                            text: "Logout"
                                            anchors.centerIn: parent
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    // Timer {
    //     id: timer
    //     interval: 1000 // Update every 1 second
    //     repeat: true
    //     running: true
    //     onTriggered: {
    //         home.get_cpu_percent()
    //     }
    // }

    // Connections {
    //     target: home
    //     function onResultsGet_cpu_percent(cpu_percent) {
    //         textCPU.text = "CPU Percent Usage: " + cpu_percent
    //         console.error(cpu_percent)
    //     }
    // }
}
