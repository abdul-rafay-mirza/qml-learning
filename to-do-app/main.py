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
        '''
        stores the text from the text field in json file
        '''

        window = self.get_window()
        if window:
            # 1. Read from notes.json and store it as a python dictionary
            json_file = open('notes.json', 'r')
            notes_dict: dict = json.load(json_file)

            # 2. Append the text from the text field inside the dictionary
            notes_dict['notes'].append(text)
            json_file.close()

            # 3. Dump the new array in the json file
            json_file_for_writing = open('notes.json', 'w')
            json.dump(notes_dict, json_file_for_writing)
            json_file_for_writing.close()

            self.list_to_javascript_qml()

    def list_to_javascript_qml(self):
        window = self.get_window()
        if window:
            # 1. Read notes from json file
            myfile = open('notes.json', 'r')
            notes: dict[list[str]] = json.load(myfile)
            myfile.close()
            notes_array = notes['notes']

            # 2. Call the javascript function inside qml file
            window.getNotes(notes_array)


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