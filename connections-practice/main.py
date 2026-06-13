import os
import sys
from pathlib import Path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtQuickControls2 import QQuickStyle

class Backend(QObject):
    # Declaring a signal
    countReachesTen = Signal(int)

    def __init__(self, engine):
        super().__init__()
        self.engine = engine
        self.clicked_count = 0

    def get_window(self):
        root_objects = self.engine.rootObjects()
        if root_objects:
            return root_objects[0]
        return None

    @Slot()
    def clicked(self):
        window = self.get_window()
        if window:
            self.clicked_count += 1
            print(f"Button Clicked!, Count: {self.clicked_count}")
            if self.clicked_count >= 10:
                self.countReachesTen.emit(self.clicked_count)


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    
    # Switch to the Breeze framework engine or else tick marks don't appear for some reason
    QQuickStyle.setStyle("org.kde.desktop")

    engine = QQmlApplicationEngine()

    backend = Backend(engine)
    engine.rootContext().setContextProperty("backend", backend)

    qml_file = Path(__file__).resolve().parent / "Main.qml"
    engine.load(str(qml_file))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())