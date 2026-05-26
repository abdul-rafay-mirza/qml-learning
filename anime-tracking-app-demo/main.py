import os
import sys
import json
from pathlib import Path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot
from PySide6.QtQuickControls2 import QQuickStyle
from Anime import Anime

class Backend(QObject):
    def __init__(self, engine):
        super().__init__()
        self.engine = engine
        self.__animeList = []

    def get_window(self):
        root_objects = self.engine.rootObjects()
        if root_objects:
            return root_objects[0]
        return None

    def json_to_anime_list(self) -> list[Anime]:
        myFile = open("animeDatabase.json", "r")
        animes_dict: dict = json.load(myFile)
        myFile.close()

        anime_list_verbose = animes_dict["data"]["Page"]["media"]

        for x in range(len(anime_list_verbose)):
            single_anime_verbose: dict = anime_list_verbose[x]

            anime_name: str = single_anime_verbose["title"]["english"]
            # print(anime_name)
            format_type: str = single_anime_verbose["format"]
            # print(format_type)
            status: str = single_anime_verbose["status"]
            # print(status)
            episodes: int = single_anime_verbose["episodes"]
            # print(episodes)
            cover_image: str = single_anime_verbose["coverImage"]["large"]
            # print(cover_image)
            average_score: int = single_anime_verbose["averageScore"]
            # print(average_score)

            anime_object = Anime(anime_name, format_type, status, episodes, cover_image, average_score)
            # print(anime_object.getName())

            self.__animeList.append(anime_object)

        return self.__animeList

    def list_to_javascript_qml(self):
        window = self.get_window()
        if window:
            window.pythonToQML(self.json_to_anime_list())



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
        backend.list_to_javascript_qml()

    # 3. Connect the signal to your function BEFORE loading the QML
    engine.objectCreated.connect(on_object_created)

    qml_file = Path(__file__).resolve().parent / "Main.qml"
    engine.load(str(qml_file))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())