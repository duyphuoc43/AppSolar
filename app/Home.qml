import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Rectangle {
    signal contactprofile
    signal contactdataBase
    signal contactcoutersolar
    signal contactdetection
    signal contactlogout
    anchors.fill: parent
    color: "#1e1e1e" // Đặt nền màu tối
    
    Image {
        id: imageBackgroud
        source: "../data/epc.jpg"
        fillMode: Image.Stretch
        anchors.fill: parent
        opacity: 1
    }

    RowLayout {
        anchors.fill: parent
        anchors.centerIn: parent

        ColumnLayout {
            width: 100
            height: 800
            Layout.leftMargin: 50
            Rectangle {
                width: 100
                height: 800
                color: "#262626"
                radius: 10
                opacity: 0.98
                Column {
                    spacing: 50
                    anchors.centerIn: parent

                    Button {
                        text: "Profile"
                        width: 80
                        height: 80
                        anchors.horizontalCenter: parent.horizontalCenter
                        // font.pixelSize: 24
                        font.family: "Arial"
                        onClicked: contactprofile()
                    }
                    Button {
                        text: "DataBase"
                        width: 80
                        height: 80
                        anchors.horizontalCenter: parent.horizontalCenter
                        // font.pixelSize: 24
                        font.family: "Arial"
                        onClicked: contactdataBase()
                    }
                    Button {
                        text: "Detection"
                        width: 80
                        height: 80
                        anchors.horizontalCenter: parent.horizontalCenter
                        // font.pixelSize: 24
                        font.family: "Arial"
                        onClicked: contactcoutersolar()
                    }
                    Button {
                        text: "History"
                        width: 80
                        height: 80
                        anchors.horizontalCenter: parent.horizontalCenter
                        // font.pixelSize: 24
                        font.family: "Arial"
                        onClicked: contactdetection()
                    }
                    Button {
                        text: "Logout"
                        width: 80
                        height: 80
                        anchors.horizontalCenter: parent.horizontalCenter
                        // font.pixelSize: 24
                        font.family: "Arial"
                        onClicked: contactlogout()
                    }
                }
            }
        }

        Rectangle {
            width: 1700
            height: 800
            color: "#333333"
            border.color: "#444444"
            border.width: 2
            radius: 8
            opacity: 0.98
            ColumnLayout {
                anchors.centerIn: parent

                Rectangle {
                    width: 1600
                    height: 400
                    color: "transparent"
                    border.color: "#444444"
                    border.width: 2
                    radius: 20

                    Row {
                        anchors.centerIn: parent

                        Rectangle {
                            width: 790
                            height: 380
                            color: "#444444"
                            border.color: "transparent"
                            radius: 20

                            Column {
                                anchors.centerIn: parent

                                Rectangle {
                                    id: profile
                                    width: 760
                                    height: 80
                                    radius: 20
                                    color: "#555555"

                                    RowLayout {
                                        Column {

                                            Text {
                                                id: info
                                                text: qsTr("Name: Duy Phước")
                                                color: "#FFFFFF"
                                                font.pixelSize: 24
                                                font.family: "Arial"
                                            }
                                            Text {
                                                id: position
                                                text: qsTr("Position: Engineer")
                                                color: "#FFFFFF"
                                                font.pixelSize: 24
                                                font.family: "Arial"
                                            }
                                        }
                                    }
                                }

                                Rectangle {
                                    width: 760
                                    height: 280
                                    color: "transparent"

                                    Row {
                                        anchors.centerIn: parent
                                        spacing: 20

                                        Rectangle {
                                            id: checkGPUandCPU
                                            width: 370
                                            height: 260
                                            color: "#666666"
                                            radius: 20

                                            ColumnLayout {
                                                anchors.fill: parent
                                                spacing: 10

                                                Text {
                                                    id: textCPU
                                                    text: "Thông tin CPU"
                                                    color: "#FFFFFF"
                                                    font.pixelSize: 15
                                                    font.family: "Arial"
                                                }
                                                Text {
                                                    id: textGPU
                                                    text: "Thông tin GPU"
                                                    color: "#FFFFFF"
                                                    font.pixelSize: 15
                                                    font.family: "Arial"
                                                }
                                                Text {
                                                    id: textRAM
                                                    text: "Thông tin RAM"
                                                    color: "#FFFFFF"
                                                    font.pixelSize: 20
                                                    font.family: "Arial"
                                                }
                                            }
                                        }

                                        Rectangle {
                                            id: checkDataBase
                                            width: 370
                                            height: 260
                                            color: "#666666"
                                            radius: 20

                                            Text {
                                                text: "Thông tin DataBase"
                                                color: "#FFFFFF"
                                                font.pixelSize: 20
                                                font.family: "Arial"
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Rectangle {
                            width: 790
                            height: 380
                            color: "transparent"

                            DataBase {
                                id: dataBase
                                visible: false

                                onButtonClicked: {
                                    dataBase.visible = false
                                }
                            }

                            GridLayout {
                                visible: !dataBase.visible
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
                                    color: "#666666"
                                    radius: 20

                                    Text {
                                        text: "Kết nối DataBase"
                                        color: "#FFFFFF"
                                        font.pixelSize: 20
                                        font.family: "Arial"
                                        anchors.centerIn: parent
                                    }
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            dataBase.visible = true
                                        }
                                    }
                                }

                                Rectangle {
                                    Layout.columnSpan: 1
                                    Layout.rowSpan: 1
                                    width: 300
                                    height: 150
                                    color: "#666666"
                                    radius: 20

                                    Text {
                                        text: "Tạo Account"
                                        color: "#FFFFFF"
                                        font.pixelSize: 20
                                        font.family: "Arial"
                                        anchors.centerIn: parent
                                    }
                                }

                                Rectangle {
                                    Layout.columnSpan: 1
                                    Layout.rowSpan: 1
                                    width: 300
                                    height: 150
                                    color: "#666666"
                                    radius: 20

                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            home.check_internet_connection()
                                        }
                                    }
                                    Text {
                                        id: textInternet
                                        text: "Kiểm tra kết nối mạng"
                                        color: "#FFFFFF"
                                        font.pixelSize: 20
                                        font.family: "Arial"
                                        anchors.centerIn: parent
                                    }
                                }

                                Rectangle {
                                    Layout.columnSpan: 1
                                    Layout.rowSpan: 1
                                    width: 300
                                    height: 150
                                    color: "#666666"
                                    radius: 20

                                    Text {
                                        text: "Lịch sử"
                                        color: "#FFFFFF"
                                        font.pixelSize: 20
                                        font.family: "Arial"
                                        anchors.centerIn: parent
                                    }
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    width: 1600
                    height: 300
                    color: "transparent"
                    radius: 20

                    RowLayout {
                        anchors.centerIn: parent
                        spacing: 134

                        Rectangle {
                            width: 300
                            height: 300
                            color: "#666666"
                            border.color: "transparent"
                            border.width: 5
                            radius: 20

                            Rectangle {
                                id: onIndicator
                                width: 150
                                height: 150
                                anchors.centerIn: parent
                                radius: 100
                                color: "green"
                                border.color: "yellow"
                                border.width: 5
                                visible: true

                                Text {
                                    text: "ON"
                                    font.pointSize: 24
                                    font.bold: true
                                    color: "#000000"
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }

                        Rectangle {
                            width: 300
                            height: 300
                            color: "#666666"
                            border.color: "transparent"
                            border.width: 5
                            radius: 20

                            Rectangle {
                                width: 150
                                height: 150
                                anchors.centerIn: parent
                                radius: 75
                                color: "#ffffff"

                                MouseArea {
                                    anchors.fill: parent

                                    Text {
                                        text: "LOCK"
                                        font.pointSize: 24
                                        font.bold: true
                                        color: "#000000"
                                        anchors.centerIn: parent
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }
                            }
                        }

                        Rectangle {
                            width: 300
                            height: 300
                            color: "#666666"
                            border.color: "transparent"
                            border.width: 5
                            radius: 20

                            Text {
                                text: "35°C"
                                font.pointSize: 48
                                font.bold: true
                                color: "#FFFFFF"
                                anchors.centerIn: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        Rectangle {
                            width: 300
                            height: 300
                            color: "#666666"
                            border.color: "transparent"
                            border.width: 5
                            radius: 20

                            Rectangle {
                                width: 150
                                height: 150
                                anchors.centerIn: parent
                                radius: 75
                                color: "#ffffff"

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        console.log("Logout clicked")
                                        contactlogout()
                                    }
                                }

                                Text {
                                    text: "LOGOUT"
                                    font.pointSize: 24
                                    font.bold: true
                                    color: "#000000"
                                    anchors.centerIn: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        home.get_cpu_info()
        home.get_ram_info()
        home.get_gpu_info()
        // home.check_internet_connection()
    }

    Connections {
        target: home
        function onResultsGet_cpu_percent(infoText) {
            textCPU.text = infoText
        }
        function onResultsGet_gpu_percent(infoText) {
            textGPU.text = infoText
        }
        function onResultsGet_ram_percent(infoText) {
            textRAM.text = infoText
        }
        function onResultsCheck_internet(infoText) {
            textInternet.text = infoText
        }
    }
}
