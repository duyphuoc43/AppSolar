from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtCore import QByteArray, QBuffer, QIODevice
from PySide6.QtGui import QImage, QPixmap
import base64
import cv2
import numpy as np
from ultralytics import YOLO
import json

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
        self.path_model = ''

    @Slot(str)
    def process_image(self, image_path):
        # Đọc ảnh
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

    @Slot(result=str)
    def detection(self):
        if not self.path_image or not self.path_model:
            print("Path to image or model is not set")
        model = YOLO(self.path_model)
        image = cv2.imread(self.path_image)
        image = cv2.resize(image,(1200,900))
        results = model(image)

        detections = []


        for result in results:
            if result.boxes is not None:
                for box in result.boxes:
                    x_min, y_min, x_max, y_max = [coord.item() for coord in box.xyxy[0]]
                    confidence = box.conf.item()
                    class_id = int(box.cls.item())
                    detection = {
                        'bbox': [x_min, y_min, x_max, y_max],
                        'confidence': confidence,
                        'class_id': class_id
                    }
                    detection_json = json.dumps(detection)
                    detections.append(detection_json)
        print(detections[0])

        # return self.resultsProcessed.emit(detections)

        a = [{'bbox': [831.34716796875,
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
        return a




