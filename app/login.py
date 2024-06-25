from PySide6.QtCore import QObject, Slot, Signal

class Login(QObject):
    loginResult = Signal(bool)
    def __init__(self):
        super().__init__()

    @Slot(str, str)
    def login(self, username, password):
        if username == "phuoc" and password == "1":
            self.loginResult.emit(True)
        else:
            self.loginResult.emit(False)
