import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import Qt.labs.platform
Rectangle {
    anchors.fill: parent

    FileDialog {
        id: fileDialog
        // currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        onAccepted : imageProcessor.process_image(selectedFile)
    }
    FolderDialog {
        id: folderDialog
        folder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        onAccepted: imageProcessor.process_model(folder)
    }
    FileDialog {
        id: fileModel
        // selectedFile : StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        nameFilters: ["*.pt"]
        onAccepted: imageProcessor.process_model(selectedFile)
    }
    RowLayout{
        ColumnLayout{
            Button {
                text: "Open Image"
                onClicked: folderDialog.open()
            }

            Button {
                text: "Chose Model"
                onClicked: fileModel.open()
            }

            Button {
                text: "Detection"
                onClicked: imageProcessor.detection()
            }
        }


        Button {
            text: "Back"
            // onClicked: fileModel.open()
        }

        Button {
            text: "Next"
            // onClicked: fileModel.open()
        }

        Rectangle {
            width: 1200
            height: 900
            Layout.alignment: Qt.AlignTop
            Image {
                id: imageView
                anchors.fill: parent
                source: "../data/home.png"
            }
            Repeater {
                id : repeaterRectangle
                model: detectionsModel
                delegate: Rectangle {
                    required property real x_box
                    required property real y_box
                    required property real w_box
                    required property real h_box
                    required property real confidence
                    required property int class_id
                    color: "transparent"
                    border.color: class_id > 1 ?  "red" : "green"
                    border.width: 2
                    x: x_box
                    y: y_box
                    width: w_box
                    height: h_box

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: textInfo.visible = true
                        onExited: textInfo.visible = false

                        Text {
                            id: textInfo
                            text: "Class ID: " + class_id + "\nConfidence: " + confidence
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
        Rectangle{
            width: 300
            height: 900
            RowLayout{
                ListView {
                    anchors.fill: parent
                    model: myList
                    delegate: Text {
                        required property int sumPanel
                        required property int age
                        text: type +  ", " + age
                    }
                }
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
            // console.error(list)
            for (var i = 0 ; i <  list.length ; i++ ) {
                detectionsModel.append(list[i])
            }
        }
    }
}
