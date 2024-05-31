import QtQuick

Rectangle {
    anchors.fill: parent
    Image {
        id : imageBackgroud
        source: "home.jpeg"
        fillMode: Image.Stretch
        anchors.fill: parent
        opacity: 0.9
    }
}
// Button {
//     text: qsTr("Choose Folder.")
//     onClicked: fileDialog.open()
// }

// FileDialog {
//     id: folderDialog
//     currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
//     onAccepted: image.source = selectedFiles
// }
