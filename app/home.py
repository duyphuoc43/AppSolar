from PySide6.QtCore import QObject, Slot, Signal
import psutil
import GPUtil
import platform
import requests


class Home(QObject):
    resultsGet_cpu_percent = Signal(str)
    resultsGet_gpu_percent = Signal(str)
    resultsGet_ram_percent = Signal(str)
    resultsCheck_internet = Signal(str)
    def __init__(self):
        super().__init__()

    @Slot()
    def get_cpu_info(self):
        cpu_model = platform.processor()
        total_cores = psutil.cpu_count(logical=True)
        result = f"CPU Model: {cpu_model}\nTotal cores: {total_cores}"
        return self.resultsGet_cpu_percent.emit(result)
    @Slot()
    def get_ram_info(self):
        svmem = psutil.virtual_memory()
        result = f"Total: {svmem.total / (1024 ** 3):.2f} GB"
        return self.resultsGet_ram_percent.emit(result)
    @Slot()
    def get_gpu_info(self):
        gpus = GPUtil.getGPUs()
        gpu_info = []
        for gpu in gpus:
            result = f"GPU Name: {gpu.name}\nTotal Memory: {gpu.memoryTotal}MB"
        return self.resultsGet_gpu_percent.emit(result)
    @Slot()
    def check_internet_connection(self):
        try:
            response = requests.get("http://www.google.com", timeout=5)
            if response.status_code == 200:
                return self.resultsCheck_internet.emit("Kết nối mạng hoạt động.")
            else:
                return self.resultsCheck_internet.emit("Không thể truy cập internet.")
        except (requests.ConnectionError, requests.Timeout):
            return self.resultsCheck_internet.emit("Không có kết nối mạng.")
