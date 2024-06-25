from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtCore import QByteArray, QBuffer, QIODevice
from PySide6.QtGui import QImage, QPixmap
import base64
import cv2
import numpy as np
from ultralytics import YOLO
import os
import mysql.connector
from mysql.connector import Error

def binaryToImage(image_binary):
    np_array = np.frombuffer(image_binary, np.uint8)
    image = cv2.imdecode(np_array, cv2.IMREAD_COLOR)
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    return image

def imageToBinary(image):
    _, image_binary = cv2.imencode('.png', image)
    image_binary = image_binary.tobytes()
    return image_binary


def base64ToImage(imageBase64):
    image_data = base64.b64decode(imageBase64)
    nparr = np.frombuffer(image_data, np.uint8)
    image = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    return image

def convertToBase64(image):
    image = cv2.resize(image,(1200, 900))
    normalized_image = cv2.normalize(image, None, alpha=0, beta=255, norm_type=cv2.NORM_MINMAX)

    _, encoded_image = cv2.imencode('.png', normalized_image)

    # Mã hóa ảnh thành base64
    base64_image = base64.b64encode(encoded_image).decode("utf-8")

    return base64_image

def convertToBase64_panel(image):

    image = cv2.resize(image,(400, 900))
    normalized_image = cv2.normalize(image, None, alpha=0, beta=255, norm_type=cv2.NORM_MINMAX)

    _, encoded_image = cv2.imencode('.png', normalized_image)

    # Mã hóa ảnh thành base64
    base64_image = base64.b64encode(encoded_image).decode("utf-8")

    return base64_image

def insert_data(table_name, columns, data):
    try:
        # Kết nối đến cơ sở dữ liệu MySQL
        connection = mysql.connector.connect(
            host="127.0.0.1",
            port = 3306,
            database='appsolar',
            user="duyphuoc",
            password="bebiu2020"
        )

        if connection.is_connected():
            cursor = connection.cursor()

            columns_str = ', '.join(columns)
            values_str = ', '.join(['%s'] * len(data))

            # Câu lệnh SQL để chèn dữ liệu
            insert_query = f"INSERT INTO {table_name} ({columns_str}) VALUES ({values_str})"

            # Thực thi câu lệnh SQL
            cursor.executemany(insert_query, data)

            # Xác nhận thay đổi
            connection.commit()
            print("Dữ liệu đã được chèn thành công")

    except Error as e:
        print(f"Lỗi khi kết nối đến MySQL: {e}")

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
            print("Đã đóng kết nối đến MySQL")

class ImageProcessor(QObject):
    imageProcessed = Signal(str)
    resultsProcessed = Signal(list)
    resultsProcessedPanel = Signal(list)
    showImagePanel = Signal(str)
    resultsEfficiency = Signal(str)
    def __init__(self):
        super().__init__()
        self.path_image = ''
        self.imageBase64 = ''
        self.path_model = ""
        self.path_folder = ''

        self.image_information = []
        self.couterImage = 0
        self.images = []
        self.panels = []
        self.general_images_panel = []
        self.general_infor_panel = []
        self.general_images_panel_erro = []
        self.general_infor_panel_erro = []
        self.indexImage = 0
        self.path_model2 = ''

    @Slot()
    def insertStringPanel(self):
        table_name = 'stringpanel'
        columns = [ 'IdArea', 'LocationString', 'Image']
        data = []
        for image in self.images:
            image_binary = imageToBinary(image)
            data.append(('1', 'block1', image_binary),)
        insert_data(table_name, columns, data)

    @Slot()
    def insertPanel(self):
        table_name = 'stringpanel'
        columns = [ 'Efficiency', 'Status', 'Location','Image','IdString']
        data = ('', 'block1',self.image_array[0])
        insert_data(table_name, columns, data)

    @Slot(int)
    def back_and_next(self,checkChose):
        self.couterImage += int(checkChose)
        if( int(self.couterImage) < 0):
            self.couterImage = 0
        elif(int(self.couterImage) > (len(self.images)-1)):
            self.couterImage = int(len(self.images)-1)

        image_base64 = convertToBase64(self.images[self.couterImage])

        self.indexImage = self.couterImage
        self.imageProcessed.emit(image_base64)

        return self.resultsProcessed.emit(self.image_information[self.couterImage])

    @Slot(str)
    def process_folder(self, path_folder):
        # Đọc ảnh
        path_folder = path_folder[8:]
        self.path_folder = path_folder
        self.images = []
        for file in os.listdir(path_folder):
            valid_extensions = ('.jpg', '.jpeg', '.png', '.bmp', '.gif')
            if file.lower().endswith(valid_extensions):  # Kiểm tra đuôi file
                link_file = os.path.join(path_folder,file)
                image = cv2.imread(link_file)
                image = cv2.resize(image, (1200, 900))
                self.images.append(image)

        return self.imageProcessed.emit(convertToBase64(self.images[0]))

    @Slot(str)
    def process_image(self, image_path):
        # Đọc ảnh
        print(image_path)
        self.path_image = image_path[8:]
        image = cv2.imread(self.path_image)
        image = cv2.resize(image, (1200, 900))
        base64_image = convertToBase64(image)
        return self.imageProcessed.emit(base64_image)

    @Slot(str)
    def process_model(self, model_path):
        # Đọc mô hình
        self.path_model = model_path[8:]
        return
    @Slot(str)
    def process_model2(self, model_path):
        # Đọc mô hình
        self.path_model2 = model_path[8:]
        return
    @Slot(result=str)
    def detection_string(self):
        if not self.path_image or not self.path_model:
            print("Path to image or model is not set")
            # self.path_model = "C:/Users/duyph/Desktop/AppPython/AppSolar/data/images - Copy/best_9e.pt"

        model = YOLO(self.path_model)

        results = model(self.images)

        for result in results:
            detections = []
            couter = 1
            if result.boxes is not None:
                for box in result.boxes:
                    x_min, y_min, x_max, y_max = [coord.item() for coord in box.xyxy[0]]
                    confidence = box.conf.item()
                    class_id = int(box.cls.item())
                    efficiency = 100
                    # location = int(couter)
                    detection = {
                        'x_box' : x_min,
                        'y_box' : y_min,
                        'w_box' : x_max-x_min,
                        'h_box' : y_max-y_min,
                        'center_x' : x_min + (x_max-x_min)/2,
                        'center_y' : y_min + (y_max-y_min)/2,
                        'confidence': round(confidence, 2),
                        'class_id': class_id,
                        'location' : 0,
                        'efficiency' : efficiency
                    }
                    detections.append(detection)
            sorted_indices = np.lexsort((np.array([d['center_x'] for d in detections]), np.array([d['center_y'] for d in detections])))
            detections = [detections[i] for i in sorted_indices]
            for detection in detections:
                detection['location'] = couter
                couter += 1

            self.image_information.append(detections)

        general_images_panel = []
        general_infor_panel = []
        for i in range(len(self.images)):
            image = self.images[i]
            detections = self.image_information[i]
            image_panels = []
            infor_panels = []
            images_panel_erro = []
            for detection in detections:
                x_min = detection['x_box']
                y_min = detection['y_box']
                x_max = x_min + detection['w_box']
                y_max = y_min + detection['h_box']
                cropped_image = image[int(y_min):int(y_max), int(x_min):int(x_max)]

                height, width, _ = np.array(cropped_image).shape
                if width > height:
                    cropped_image = cv2.rotate(cropped_image, cv2.ROTATE_90_CLOCKWISE)
                resized_image = cv2.resize(cropped_image, (300, 900))
                image_panels.append(resized_image)
                infor_panels.append(detection)

                if detection['class_id'] != 2:
                    images_panel_erro.append(cropped_image)
            # self.general_images_panel_erro.append(images_panel_erro)

            general_images_panel.append(image_panels)
            general_infor_panel.append(infor_panels)
            self.general_images_panel = general_images_panel
            self.general_infor_panel = general_infor_panel

        return self.resultsProcessed.emit(self.image_information[0])

# *************************************************************************************************************
    @Slot(result=str)
    def detection_panel(self):
        # self.path_model2 = "C:/Users/duyph/Desktop/AppPython/AppSolar/data/images - Copy/faultbest1.pt"
        # Tải mô hình YOLO
        model = YOLO(self.path_model2)

        # Lưu trữ kết quả phân tích từng hình ảnh
        images_results = []
        for images_erro in self.general_images_panel:
            results = model(images_erro)
            images_results.append(results)

        # Lưu trữ các phát hiện trên từng hình ảnh
        images_detections = []
        for results_image in images_results:
            image_detections = []

            for result in results_image:
                detections = []

                if result.boxes is not None:
                    for box in result.boxes:
                        x_min, y_min, x_max, y_max = [coord.item() for coord in box.xyxy[0]]
                        confidence = box.conf.item()
                        class_id = int(box.cls.item())
                        efficiency = 100
                        # location = int(couter)
                        detection = {
                            'x_box' : x_min,
                            'y_box' : y_min,
                            'w_box' : x_max - x_min,
                            'h_box' : y_max - y_min,
                            'center_x' : x_min + (x_max - x_min) / 2,
                            'center_y' : y_min + (y_max - y_min) / 2,
                            'confidence': round(confidence, 2),
                            'class_id': class_id,
                            'location' : 0,
                            'efficiency' : efficiency
                        }
                        detections.append(detection)
                image_detections.append(detections)
            images_detections.append(image_detections)

        # Lưu trữ thông tin phân tích tổng quát
        self.general_infor_panel_erro = images_detections

        return

    @Slot(int)
    def show_panel(self,index):
        image_panel = self.general_images_panel[self.indexImage][index]
        image_panel = convertToBase64_panel(image_panel)
        efficiency = 100
        # print(self.indexImage,index, len(self.general_infor_panel_erro[self.indexImage][index]))

        for detection in self.general_infor_panel_erro[self.indexImage][index]:
            if (detection['class_id'] == 1):
                efficiency -= 100*(1/3)
            if (detection['class_id'] == 0):
                efficiency -= 100*(1/6)
            if (detection['class_id'] == 2):
                efficiency -= (detection['w_box'] *  detection['h_box']) / (900*300) *100

        self.resultsProcessedPanel.emit(self.general_infor_panel_erro[self.indexImage][index])
        efficiency = round(efficiency, 2)
        self.resultsEfficiency.emit(str(efficiency))
        return self.showImagePanel.emit(image_panel)
