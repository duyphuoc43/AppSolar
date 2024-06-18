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
    Home {
        id : homePage
        visible : true
        onContactprofile: {
            // homePage.visible = false;
            // loginPage.visible = false;
        }
        onContactdataBase: {
            homePage.visible = false;
            dataBasePage.visible = true;
        }
        onContactcoutersolar: {
            homePage.visible = false;
            couterPage.visible = true;
        }
        onContactdetection: {
            // homePage.visible = true;
            // loginPage.visible = false;
        }
        onContactlogout: {
            homePage.visible = false;
            loginPage.visible = true;
        }
    }
    CouterPanel{
        id : couterPage
        visible : false
    }
    // DataBase{
    //     id : dataBasePage
    //     visible : false
    // }
}




