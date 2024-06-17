from PySide6.QtCore import QObject, Slot, Signal
import psutil
import GPUtil
import platform



class Home(QObject):
    resultsGet_cpu_percent = Signal(str)
    def __init__(self):
        super().__init__()

    @Slot()
    def get_cpu_info():
        return {
            "CPU Model": platform.processor(),
            "Total cores": psutil.cpu_count(logical=True),
        }
    @Slot()
    def get_ram_info():
        svmem = psutil.virtual_memory()
        return {
            "Total": f"{svmem.total / (1024 ** 3):.2f} GB",
        }
    @Slot()
    def get_gpu_info():
        gpus = GPUtil.getGPUs()
        gpu_info = []
        for gpu in gpus:
            gpu_info.append({
                "GPU Name": gpu.name,
                "Total Memory": f"{gpu.memoryTotal}MB",
            })
        return gpu_info

