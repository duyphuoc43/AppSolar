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
        file: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        onAccepted : imageProcessor.process_image(file)
    }
    FolderDialog {
        id: folderDialog
        folder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        onAccepted: imageProcessor.process_folder(folder)
    }
    FileDialog {
        id: fileModel
        file : StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        nameFilters: ["*.pt"]
        onAccepted: imageProcessor.process_model(file)
    }
    RowLayout{
        ColumnLayout{
            Button {
                text: "Chose Image"
                onClicked: fileDialog.open()
            }
            Button {
                text: "Chose Folder"
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
            onClicked: imageProcessor.back_and_next(-1)
        }

        Button {
            text: "Next"
            onClicked: imageProcessor.back_and_next(1)
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
                    required property int location
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
                        onEntered: {

                            textInfo.visible = true
                            information.text = "Status of the solar panel:"
                                    +'\nLocation:' + location
                                    + "\nClass ID: " + class_id
                                    + "\nConfidence: " + confidence
                        }
                        onExited: textInfo.visible = false

                        Text {
                            id: textInfo
                            text: 'location:' + location + "Class ID: " + class_id + "\nConfidence: " + confidence
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
            // color : "red"
            ColumnLayout{
                Text {
                    id : information
                    text: "Status of the solar panel:"
                }
                Text {
                    text: "Information of solar:"
                            // + "\nSum panel : " +  list.length+1
                }
            }
            // RowLayout{
                // ListView {
                //     anchors.fill: parent
                //     model: detectionsModel
                //     delegate: Text {
                //         required property int location
                //         required property int age
                //         text: "Location : " + location + "/n"
                //                 + "Class ID: " + class_id + "/n"
                //                 + "Confidence: " + confidence
                //     }
                // }
            // }
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
