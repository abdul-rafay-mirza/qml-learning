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

    # The @Slot() decorator makes this Python function visible to QML
    @Slot()
    def change_text(self):
        print("Button clicked in QML, handled in Python!")
        
        # Find the root object (the ApplicationWindow) to call its JS function
        root_objects = self.engine.rootObjects()
        if root_objects:
            root_window = root_objects[0]
            # Call the 'updateText' function inside main.qml
            root_window.updateText("Python changed this text!")

    @Slot()
    def say_hi(self):
        print("hi")

    @Slot()
    def increase_size(self):
        # get the parent of the js function makeTextBig()
        parent = self.engine.rootObjects()[0]
        parent.makeTextBig()

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # 2. Instantiate the backend
    backend = Backend(engine)

    # 3. Expose the Python object to QML's context
    # This allows QML to use the variable name 'backend'
    engine.rootContext().setContextProperty("backend", backend)

    # 4. Load the QML file
    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(str(qml_file))

    # Check if the QML file loaded successfully
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())