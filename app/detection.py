from PySide6.QtCore import QObject, Slot, Signal
from couterPanel import ImageProcessor
class Detection(QObject):

    def __init__(self):
        super().__init__()

    @Slot()
    def getInformation(self):
        return
