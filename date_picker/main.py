import os
import sys
import json
from pathlib import Path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot
from PySide6.QtQuickControls2 import QQuickStyle 

class Backend(QObject):
    def __init__(self, engine):
        super().__init__()
        self.engine = engine

    def get_window(self):
        root_objects = self.engine.rootObjects()
        if root_objects:
            return root_objects[0]
        return None

    @Slot(str)
    def get_text_from_text_field(self, text: str):
        window = self.get_window()
        if window:
            pass

    def _load(self):
        window = self.get_window()
        if window:
           print("Program Started!")


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    
    # Switch to the Breeze framework engine or else tick marks don't appear for some reason
    QQuickStyle.setStyle("org.kde.desktop")

    engine = QQmlApplicationEngine()

    backend = Backend(engine)
    engine.rootContext().setContextProperty("backend", backend)

    # 1. Define a function that runs exactly when the engine finishes building the window
    def on_object_created(obj, obj_url):
        if obj is None:
            sys.exit(-1)
        # 2. Call your json loading method here!
        backend._load()

    # 3. Connect the signal to your function BEFORE loading the QML
    engine.objectCreated.connect(on_object_created)

    qml_file = Path(__file__).resolve().parent / "Main.qml"
    engine.load(str(qml_file))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())