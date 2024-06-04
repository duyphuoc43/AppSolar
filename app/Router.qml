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
        }
    }
    Home {
        id : homePage
        visible : false
        onProfile:{
            couterPage.visible = true;
            homePage.visible = false;
        }
        onDataBase:{
            couterPage.visible = true;
            homePage.visible = false;
        }
        onCouterSolar:{
            couterPage.visible = true;
            homePage.visible = false;
        }
        onDetection:{
            couterPage.visible = true;
            homePage.visible = false;
        }
        onLogout:{
            homePage.visible = false;
            couterPage.visible = false;
            loginPage.visible = true;
        }
    }
    CouterPanel{
        id : couterPage
        visible : false
    }
}




