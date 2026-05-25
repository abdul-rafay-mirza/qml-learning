import sys
from pathlib import Path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot

# 1. Define a backend class that QML can interact with
class Backend(QObject):
    def __init__(self, engine):
        super().__init__()
        self.engine = engine

    def get_window(self):
        root_objects = self.engine.rootObjects()
        if root_objects:
            return root_objects[0]
        return None

    @Slot()
    def change_color_red(self):
        window = self.get_window()
        if window:
                window.changeColorRed()

    @Slot()
    def change_color_green(self):
        window = self.get_window()
        if window:
                window.changeColorGreen()

    @Slot()
    def change_color_blue(self):
        window = self.get_window()
        if window:
                window.changeColorBlue()


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # 2. Instantiate the backend
    backend = Backend(engine)

    # 3. Expose the Python object to QML's context
    # This allows QML to use the variable name 'backend'
    engine.rootContext().setContextProperty("backend", backend)

    # 4. Load the QML file
    qml_file = Path(__file__).resolve().parent / "Main.qml"
    engine.load(str(qml_file))

    # Check if the QML file loaded successfully
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())