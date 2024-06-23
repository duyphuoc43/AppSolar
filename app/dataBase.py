from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtCore import QByteArray, QBuffer, QIODevice
from PySide6.QtGui import QImage, QPixmap
import mysql.connector
from mysql.connector import Error
import base64
import cv2
import numpy as np
import os

from couterPanel import ImageProcessor

class DataBase(QObject):

    resultsConnectDataBase = Signal(str)
    # resultsProcessed = Signal(list)

    def __init__(self):
        super().__init__()
        self.connection = ''
        self.cursor = ''
        self.image_infor = []
        self.image_processor = ImageProcessor()
    @Slot(str,int,str,str,str)
    def connectDataBase(self, hostText, portText, databaseText, userText, passwordText):
        self.connection = mysql.connector.connect(
            host="127.0.0.1",
            port = 3306,
            database='appsolar',
            user="duyphuoc",
            password="bebiu2020"
            # host=hostText,
            # port = int(portText),
            # database=databaseText,
            # user=userText,
            # password=passwordText
        )
        if self.connection.is_connected():
            print("Connected to MySQL database")
            self.cursor = self.connection.cursor()
            return self.resultsConnectDataBase.emit("Connected to MySQL database")
        return self.resultsConnectDataBase.emit("Disconnected to MySQL database")

    @Slot(str,str,str)
    def insertCompany(self, idCompany, date = None, address = None):
        insert_query = "INSERT INTO company (idCompany ,name, address) VALUES (%s,%s, %s)"
        records_to_insert = [(10,"John", "Highway 21")]
        self.cursor.executemany(insert_query, records_to_insert)
        self.connection.commit()

    @Slot(str,str,str)
    def insertStringPanel(self, idArea, area, locationString, image):
        insert_query = "INSERT INTO stringpanel (idArea, area, locationString, image) VALUES (%s,%s, %s,%s)"
        records_to_insert = [("1", 'John Doe', self.image_information , self.image_array)]
        self.cursor.executemany(insert_query, records_to_insert)
        self.connection.commit()

    @Slot()
    def check(self):
        self.image_infor = self.image_processor.getInforAndImage()
        print(len(self.image_infor[0]))
        return


