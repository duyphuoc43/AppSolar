# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QUrl, QObject, Signal, Slot

from login import Login
from couterPanel import ImageProcessor
if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # login_controller = Login()
    # engine.rootContext().setContextProperty("loginController", login_controller)
    # print("loginController has been created:", login_controller)

    imageProcessor = ImageProcessor()
    engine.rootContext().setContextProperty("imageProcessor", imageProcessor)


    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
