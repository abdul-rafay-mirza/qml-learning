import os
import sys
import json
from pathlib import Path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal, Property
from PySide6.QtQuickControls2 import QQuickStyle

class Person(QObject):
    def __init__(self, name: str, age: int, gender: str):
        super().__init__()
        self.__name = name
        self.__age = age
        self.__gender = gender

    # Signals
    nameChanged = Signal()
    ageChanged = Signal()
    genderChanged = Signal()

    def getName(self):
        return self.__name

    def getAge(self):
        return self.__age

    def getGender(self):
        return self.__gender

    def setName(self, name: str):
        self.__name = name
        self.nameChanged.emit()

    def setAge(self, age: int):
        self.__age = age
        self.ageChanged.emit()

    def setGender(self, gender: str):
        self.__gender = gender
        self.genderChanged.emit()

    # Binding into a Qt property
    name = Property(str, fget = getName, fset = setName, notify = nameChanged)
    age = Property(int, fget = getAge, fset = setAge, notify = ageChanged)
    gender = Property(str, fget = getGender, fset = setGender, notify = genderChanged)

class Backend(QObject):
    def __init__(self, engine):
        super().__init__()
        self.engine = engine

    def get_window(self):
        root_objects = self.engine.rootObjects()
        if root_objects:
            return root_objects[0]
        return None


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    QQuickStyle.setStyle("org.kde.desktop")
    engine = QQmlApplicationEngine()
    backend = Backend(engine)

    # Creating an object of type Person
    person1 = Person("Bob", 22, "Male")

    engine.rootContext().setContextProperty("backend", backend)

    # person1 will now be an object inside QML
    engine.rootContext().setContextProperty("person1", person1)

    qml_file = Path(__file__).resolve().parent / "Main.qml"
    engine.load(str(qml_file))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())