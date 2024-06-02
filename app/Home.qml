import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
Rectangle {
    anchors.fill: parent
    Image {
        id : imageBackgroud
        source: "../data/epc.jpg"
        fillMode: Image.Stretch
        anchors.fill: parent
        opacity: 0.9
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
                    color : "#240436"
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
                        }
                        Button {
                           text: "DataBase"
                           width: 80
                           height: 80
                           anchors.horizontalCenter: parent.horizontalCenter
                           // font.pixelSize: 24
                        }
                        Button {
                           text: "Couter Solar"
                           width: 80
                           height: 80
                           anchors.horizontalCenter: parent.horizontalCenter
                           // font.pixelSize: 24
                        }
                        Button {
                           text: "Detection"
                           width: 80
                           height: 80
                           anchors.horizontalCenter: parent.horizontalCenter
                           // font.pixelSize: 24
                        }
                        Button {
                           text: "Logout"
                           width: 80
                           height: 80
                           anchors.horizontalCenter: parent.horizontalCenter
                           // font.pixelSize: 24
                        }
                    }
                }
            }
            Rectangle{
                width: 1700
                height: 800
                color : "blue"
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
                                color : "transparent"
                                border.color: "black"
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
                                                color : "red"
                                                radius : 20
                                            }
                                            Rectangle{
                                                id : checkDataBase
                                                width: 370
                                                height: 260
                                                color : "pink"
                                                radius : 20
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
                                        color: "red"
                                        radius : 20
                                    }

                                    Rectangle {
                                        Layout.columnSpan: 1
                                        Layout.rowSpan: 1
                                        width: 300
                                        height: 150
                                        color: "green"
                                        radius : 20
                                    }

                                    Rectangle {
                                        Layout.columnSpan: 1
                                        Layout.rowSpan: 1
                                        width: 300
                                        height: 150
                                        color: "pink"
                                        radius : 20
                                    }

                                    Rectangle {
                                        Layout.columnSpan: 1
                                        Layout.rowSpan: 1
                                        width: 300
                                        height: 150
                                        color: "yellow"
                                        radius : 20
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
                                color : "green"
                                border.color: "black"
                                border.width: 5
                                radius : 20
                            }
                            Rectangle{
                                width: 300
                                height: 300
                                color : "green"
                                border.color: "black"
                                border.width: 5
                                radius : 20
                            }
                            Rectangle{
                                width: 300
                                height: 300
                                color : "green"
                                border.color: "black"
                                border.width: 5
                                radius : 20
                            }
                            Rectangle{
                                width: 300
                                height: 300
                                color : "green"
                                border.color: "black"
                                border.width: 5
                                radius : 20
                            }
                        }
                    }
                }
            }
        }
    }
}
