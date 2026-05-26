from PySide6.QtCore import QObject, Signal, Property

class Anime(QObject):
    def __init__(self, animeName: str,
                        formatType: str,        # TV, ONA stuff
                        status: str,            # FINISHED, ONGOING
                        episodes: int,
                        coverImage: str,        # A URL of the image
                        averageScore: int,
                 ):
        self.__animeName = animeName
        self.__formatType = formatType
        self.__status = status
        self.__episodes = episodes
        self.__coverImage = coverImage
        self.__averageScore = averageScore

        # Signals
        animeNameChanged = Signal()
        formatTypeChanged = Signal()
        statusChanged = Signal()
        episodesChanged = Signal()
        coverImageChanged = Signal()
        averageScoreChanged = Signal()

        def getAnimeName(self) -> str:
            return self.__animeName

        def getFormatType(self) -> str:
            return self.__formatType

        def getStatus(self) -> str:
            return self.__status

        def getEpisodes(self) -> int:
            return self.__episodes

        def getCoverImage(self) -> str:
            return self.__coverImage

        def getAverageScore(self) -> int:
            return self.__averageScore

        def setAnimeName(self, animeName: str):
            self.__animeName = animeName
            self.animeNameChanged.emit()

        def setFormatType(self, formatType: str):
            self.__formatType = formatType
            self.formatTypeChanged.emit()

        def setStatus(self, status: str):
            self.__status = status
            self.statusChanged.emit()

        def setEpisodes(self, episodes: int):
            self.__episodes = episodes
            self.episodesChanged.emit()

        def setCoverImage(self, coverImage: str):
            self.__coverImage = coverImage
            self.coverImageChanged.emit()

        def setAverageScore(self, averageScore: int):
            self.__averageScore = averageScore
            self.averageScoreChanged.emit()

        # Binding into a Qt property (so that we can do something like animeObject.name in QML)
        name = Property(str, fget=getAnimeName, fset=setAnimeName, notify=animeNameChanged)
        formatType = Property(str, fget=getFormatType, fset=setFormatType, notify=formatTypeChanged)
        status = Property(str, fget=getStatus, fset=setStatus, notify=statusChanged)
        episodes = Property(int, fget=getEpisodes, fset=setEpisodes, notify=episodesChanged)
        coverImage = Property(str, fget=getCoverImage, fset=setCoverImage, notify=coverImageChanged)
        averageScore = Property(int, fget=getAverageScore, fset=setAverageScore, notify=averageScoreChanged)

