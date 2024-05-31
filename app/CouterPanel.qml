import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
Rectangle {
    anchors.fill: parent

    FileDialog {
        id: fileDialog
        // currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        onAccepted : imageProcessor.process_image(selectedFile)
    }

    FileDialog {
        id: fileModel
        // selectedFile : StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        nameFilters: ["*.pt"]
        onAccepted: imageProcessor.process_model(selectedFile)
    }

    ColumnLayout{

        Button {
            text: "Open Image"
            onClicked: fileDialog.open()
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

    Rectangle {
        width: 1200
        height: 900
        x : 100
        Image {
            id: imageView
            anchors.fill: parent
            source: "../data/home.png"
        }
    }
    Repeater {
        id : repeaterRectangle
        model: [{'bbox': [831.34716796875,
                    68.8214111328125,
                    904.4148559570312,
                    103.6904525756836],
                   'confidence': 0.8047338128089905,
                   'class_id': 0},
            {'bbox': [574.1788330078125, 801.4324951171875, 647.34375, 833.5603637695312],
             'confidence': 0.8023658990859985,
             'class_id': 0},
            {'bbox': [516.3645629882812,
              426.8780822753906,
              589.8557739257812,
              461.0565490722656],
             'confidence': 0.8021420240402222,
             'class_id': 0}]

        delegate: Rectangle {
            color: "transparent"
            border.color: "red"
            border.width: 2
            x: modelData.bbox[0]
            y: modelData.bbox[1]
            width: modelData.bbox[2] - modelData.bbox[0]
            height: modelData.bbox[3] - modelData.bbox[1]
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
    }
}
