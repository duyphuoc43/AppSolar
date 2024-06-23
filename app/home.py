from PySide6.QtCore import QObject, Slot, Signal
import psutil
import GPUtil
import platform
import requests
import subprocess
def get_cpu_name():
    if platform.system() == "Windows":
        try:
            command = "wmic cpu get name"
            cpu_info = subprocess.check_output(command, shell=True).strip().decode().split('\n')
            return cpu_info[1].strip()
        except subprocess.CalledProcessError:
            return "Unknown CPU"
    elif platform.system() == "Darwin":
        try:
            command = "sysctl -n machdep.cpu.brand_string"
            cpu_name = subprocess.check_output(command, shell=True).strip().decode()
            return cpu_name
        except subprocess.CalledProcessError:
            return "Unknown CPU"
    elif platform.system() == "Linux":
        try:
            command = "cat /proc/cpuinfo | grep 'model name' | head -1"
            cpu_info = subprocess.check_output(command, shell=True).strip().decode()
            cpu_name = cpu_info.split(":")[1].strip()
            return cpu_name
        except subprocess.CalledProcessError:
            return "Unknown CPU"
    return "Unknown CPU"

class Home(QObject):
    resultsGet_cpu_percent = Signal(str)
    resultsGet_gpu_percent = Signal(str)
    resultsGet_ram_percent = Signal(str)
    resultsCheck_internet = Signal(str)
    def __init__(self):
        super().__init__()

    @Slot()
    def get_cpu_info(self):
        return self.resultsGet_cpu_percent.emit(f"CPU Model: {get_cpu_name()}")
    
    @Slot()
    def get_ram_info(self):
        svmem = psutil.virtual_memory()
        result = f"RAM: {svmem.total / (1024 ** 3):.2f} GB"
        return self.resultsGet_ram_percent.emit(result)
    @Slot()
    def get_gpu_info(self):
        gpus = GPUtil.getGPUs()
        gpu_info = []
        for gpu in gpus:
            result = f"GPU Model: {gpu.name}\nTotal Memory: {gpu.memoryTotal}MB"
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
