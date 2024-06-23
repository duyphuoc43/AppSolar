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
    color: "#333333"  // Màu nền tối

    FileDialog {
        id: fileDialog
        file: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        onAccepted: imageProcessor.process_image(file)
    }
    FolderDialog {
        id: folderDialog
        folder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        onAccepted: imageProcessor.process_folder(folder)
    }
    FileDialog {
        id: fileModel
        file: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        nameFilters: ["*.pt"]
        onAccepted: imageProcessor.process_model(file)
    }

    RowLayout {
        anchors.fill: parent
        Rectangle {
            width: 300
            height: 1080
            color: "#444444"  // Màu nền tối hơn
            radius: 20
            Button{
                id: backHome
                width: 100
                height: 60
                onClicked: back_home()
                text: "Back Home"
            }
            ColumnLayout {
                anchors.centerIn: parent

                Rectangle {
                    width: 200
                    height: 50

                    Row {
                        Button {
                            text: "Chọn Ảnh"
                            onClicked: fileDialog.open()
                            width: 100
                            height: 50
                        }
                        Button {
                            text: "Chọn Thư Mục"
                            onClicked: folderDialog.open()
                            width: 100
                            height: 50
                        }
                    }
                }

                Rectangle {
                    width: 200
                    height: 50
                    Button {
                        text: "Chọn Mô Hình"
                        onClicked: fileModel.open()
                        width: 200
                        height: 50
                    }
                }

                Rectangle {
                    width: 200
                    height: 50
                    Button {
                        text: "Phát Hiện"
                        onClicked: imageProcessor.detection()
                        width: 200
                        height: 50
                    }
                }
                Rectangle {
                    width: 200
                    height: 50
                    Button {
                        text: "Lưu vào DataBase"
                        onClicked: imageProcessor.insertStringPanel()
                        width: 200
                        height: 50
                    }
                }
                Rectangle {
                    width: 200
                    height: 600
                    border.color: "white"
                    border.width: 2
                    radius: 20
                    Text {
                        text: "Thông tin của pin mặt trời"
                        anchors.centerIn: parent
                        color: "white"
                    }
                }
            }
        }

        Rectangle {
            width: 1200
            height: parent.height
            color: "#444444"  // Màu nền tối hơn

            ColumnLayout {
                anchors.centerIn: parent

                Rectangle {
                    width: 1200
                    height: 900

                    Image {
                        id: imageView
                        anchors.fill: parent
                        source: "../data/home.png"
                    }

                    Repeater {
                        id: repeaterRectangle
                        model: detectionsModel
                        delegate: Rectangle {
                            required property real x_box
                            required property real y_box
                            required property real w_box
                            required property real h_box
                            required property real confidence
                            required property int class_id
                            required property int location

                            color: "transparent"
                            border.color: class_id > 1 ? "red" : "green"
                            border.width: 2
                            x: x_box
                            y: y_box
                            width: w_box
                            height: h_box

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    textInfo.visible = true
                                    information.text = "Trạng thái của pin mặt trời:" +
                                                      '\nVị trí: ' + location +
                                                      "\nClass ID: " + class_id +
                                                      "\nĐộ chắc chắn: " + confidence
                                }
                                onExited: textInfo.visible = false

                                Text {
                                    id: textInfo
                                    text: 'Vị trí: ' + location + "Class ID: " + class_id + "\nĐộ chắc chắn: " + confidence
                                    color: "white"
                                    visible: false
                                    anchors {
                                        top: parent.top
                                        left: parent.left
                                    }
                                }
                            }
                        }
                    }
                }

                Row {
                    Button {
                        text: "Quay Lại"
                        onClicked: imageProcessor.back_and_next(-1)
                        width: 600
                        height: 30
                    }

                    Button {
                        text: "Tiếp Theo"
                        onClicked: imageProcessor.back_and_next(1)
                        width: 600
                        height: 30
                    }
                }
            }
        }

        Rectangle {
            width: 300
            height: 900
            color: "#444444"  // Màu nền tối hơn
            Column {
                Text {
                    id: information
                    text: "Trạng thái của pin mặt trời:"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                    font.pixelSize: 18
                    color: "white"
                }
                // Text {
                //     text: "Thông tin về pin mặt trời:"
                //     anchors.horizontalCenter: parent.horizontalCenter
                //     font.pixelSize: 16
                //     color: "white"
                // }
            }
        }
    }

    ListModel {
        id: detectionsModel
    }

    Connections {
        target: imageProcessor
        function onImageProcessed(base64_image) {
            imageView.source = "data:image/png;base64," + base64_image
        }
        function onResultsProcessed(list) {
            detectionsModel.clear()
            for (var i = 0 ; i <  list.length ; i++ ) {
                detectionsModel.append(list[i])
            }
        }
    }
}
