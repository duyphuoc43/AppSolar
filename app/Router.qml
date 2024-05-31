import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls

Item{
    id : root
    anchors.fill: parent
    anchors.centerIn: parent
    // Login{
    //     visible : true
    //     id : loginPage
    //     onLoginSuccessful: {
    //         homePage.visible = true;
    //         loginPage.visible = false;
    //     }
    // }

    // Home {
    //     id : homePage
    //     visible : false
    // }

    CouterPanel{
        id : couterPage
        visible : true
    }
}




