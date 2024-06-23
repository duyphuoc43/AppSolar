import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls

Item{
    id : root
    anchors.fill: parent
    anchors.centerIn: parent
    Login{
        visible : true
        id : loginPage
        onLoginSuccessful: {
            homePage.visible = true;
            loginPage.visible = false;
        }
    }
    Home {
        id : homePage
        visible : false
        onContactprofile: {
            // homePage.visible = false;
            // loginPage.visible = false;
        }
        onContactdataBase: {
            // homePage.visible = false;
            // dataBasePage.visible = true;
        }
        onContactcoutersolar: {
            homePage.visible = false;
            couterPage.visible = true;
        }
        onContactdetection: {
            detectionPage.visible = true;
            homePage.visible = false;
        }
        onContactlogout: {
            homePage.visible = false;
            loginPage.visible = true;
        }
    }
    CouterPanel{
        id : couterPage
        visible : true
        onBack_home: {
            couterPage.visible = false;
            homePage.visible = true;
        }
    }
    Detection{
        id : detectionPage
        visible : false
    }
}




