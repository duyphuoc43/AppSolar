from PySide6.QtCore import QObject, Slot, Signal
import psutil
import subprocess
import re
import threading
import time

def get_gpu_info():
    try:
        output = subprocess.check_output(['nvidia-smi', '--query-gpu=index,utilization.gpu,utilization.memory', '--format=csv,noheader,nounits'])
        gpu_info = output.decode('utf-8').strip().split('\n')
        result = []
        for gpu in gpu_info:
            index, gpu_util, memory_util = gpu.split(',')
            result.append({
                'index': int(index),
                'gpu_utilization': float(gpu_util),
                'memory_utilization': float(memory_util)
            })
        return result
    except Exception as e:
        print("Error:", e)
        return None
class Home(QObject):
    resultsGet_cpu_percent = Signal(str)
    def __init__(self):
        super().__init__()

    @Slot()
    def get_cpu_percent(self):
        cpu_percent = psutil.cpu_percent(interval=1)
        print(cpu_percent)
        return self.resultsGet_cpu_percent.emit(str(cpu_percent))

    @Slot()
    def get_gpu(self):
        gpu_info = get_gpu_info()
        if gpu_info:
            for gpu in gpu_info:
                return(f"GPU {gpu['index']} Utilization: {gpu['gpu_utilization']}%"+f"\nMemory Utilization: {gpu['memory_utilization']}%")
        else:
            return("Failed to retrieve GPU information.")
    @Slot()
    def get_ram_percent(self):
        ram_percent = psutil.virtual_memory().percent
        return ram_percent
