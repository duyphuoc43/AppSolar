from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtCore import QByteArray, QBuffer, QIODevice
from PySide6.QtGui import QImage, QPixmap
import base64
import cv2
import numpy as np
from ultralytics import YOLO
import os


def base64ToImage(imageBase64):
    image_data = base64.b64decode(imageBase64)
    nparr = np.frombuffer(image_data, np.uint8)
    image = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    return image
def convertToBase64(image):
    image = cv2.resize(image,(900,700))
    normalized_image = cv2.normalize(image, None, alpha=0, beta=255, norm_type=cv2.NORM_MINMAX)

    _, encoded_image = cv2.imencode('.png', normalized_image)

    # Mã hóa ảnh thành base64
    base64_image = base64.b64encode(encoded_image).decode("utf-8")

    return base64_image
class ImageProcessor(QObject):
    imageProcessed = Signal(str)
    resultsProcessed = Signal(list)

    def __init__(self):
        super().__init__()
        self.path_image = ''
        self.imageBase64 = ''
        self.path_model = ''
        self.path_folder = ''
        self.image_array = []
        self.image_information = []
        self.couterImage = 0


    @Slot(int)
    def back_and_next(self,checkChose):
        self.couterImage += int(checkChose)
        if( 0 > int(self.couterImage)):
            self.couterImage = 0
        elif(int(self.couterImage) > len(self.image_array)):
            self.couterImage = int(len(self.image_array))

        self.imageProcessed.emit(self.image_array[self.couterImage])
        return self.resultsProcessed.emit(self.image_information[self.couterImage])


    @Slot(str)
    def process_folder(self, path_folder):
        # Đọc ảnh
        path_folder = path_folder[8:]
        self.path_folder = path_folder
        for file in os.listdir(path_folder):
            link_file = os.path.join(path_folder,file)
            image = cv2.imread(link_file)
            image = cv2.resize(image, (1200, 900))
            base64_image = convertToBase64(image)
            self.image_array.append(base64_image)
        return self.imageProcessed.emit(self.image_array[0])

    @Slot(str)
    def process_image(self, image_path):
        # Đọc ảnh
        print(image_path)
        self.path_image = image_path[8:]
        image = cv2.imread(self.path_image)
        image = cv2.resize(image, (1200, 900))
        base64_image = convertToBase64(image)
        self.imageBase64 = base64_image
        return self.imageProcessed.emit(base64_image)

    @Slot(str)
    def process_model(self, model_path):
        # Đọc mô hình
        self.path_model = model_path[8:]
        return

    @Slot(result=str)
    def detection(self):
        if not self.path_image or not self.path_model:
            print("Path to image or model is not set")

        model = YOLO(self.path_model)
        images = []
        for image in self.image_array:
            image = base64ToImage(image)
            image = cv2.resize(image,(1200,900))
            images.append(image)
        results = model(images)

        for result in results:
            detections = []
            couter = 1
            if result.boxes is not None:
                for box in result.boxes:
                    x_min, y_min, x_max, y_max = [coord.item() for coord in box.xyxy[0]]
                    confidence = box.conf.item()
                    class_id = int(box.cls.item())
                    # location = int(couter)
                    detection = {
                        'x_box' : x_min,
                        'y_box' : y_min,
                        'w_box' : x_max-x_min,
                        'h_box' : y_max-y_min,
                        'center_x' : x_min + (x_max-x_min)/2,
                        'center_y' : y_min + (y_max-y_min)/2,
                        'confidence': confidence,
                        'class_id': class_id,
                        'location' : 0
                    }
                    detections.append(detection)

            sorted_indices = np.lexsort((np.array([d['center_x'] for d in detections]), np.array([d['center_y'] for d in detections])))
            detections = [detections[i] for i in sorted_indices]
            for detection in detections:
                detection['location'] = couter
                couter += 1


            self.image_information.append(detections)

        return self.resultsProcessed.emit(self.image_information[0])



