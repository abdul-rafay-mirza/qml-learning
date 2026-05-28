import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    width: 800
    height: 600
    title: "Hamburger Menu Demo"

    Kirigami.PagePool {
        id: appPagePool
    }

    // Use Component.onCompleted to push after the window is fully ready
    // and use loadPage() not load()
    Component.onCompleted: {
        pageStack.push(appPagePool.loadPage(Qt.resolvedUrl("Homepage.qml"))) // Give it another path like Trash.qml and it will work
    }

    globalDrawer: Kirigami.GlobalDrawer {
        id: globalDrawer
        modal: false
        collapsible: true
        collapsed: false
        collapseButtonVisible: false
        showHeaderWhenCollapsed: true

        header: Controls.ToolBar {
            contentItem: RowLayout {
                Layout.fillWidth: true

                Controls.ToolButton {
                    icon.name: "application-menu"
                    visible: globalDrawer.collapsible
                    checked: !globalDrawer.collapsed
                    onClicked: globalDrawer.collapsed = !globalDrawer.collapsed
                }

                Controls.Label {
                    text: "Menu"
                    visible: !globalDrawer.collapsed
                }
            }
        }

        actions: [
            Kirigami.PagePoolAction {
                text: "Homepage"
                icon.name: "go-home-symbolic"
                pagePool: appPagePool
                page: Qt.resolvedUrl("Homepage.qml")
                pageStack: root.pageStack
            },
            Kirigami.PagePoolAction {
                text: "Trash"
                icon.name: "albumfolder-user-trash"
                pagePool: appPagePool
                page: Qt.resolvedUrl("Trash.qml")
                pageStack: root.pageStack
            },
            Kirigami.PagePoolAction {
                text: "Bookmarks"
                icon.name: "bookmarks"
                pagePool: appPagePool
                page: Qt.resolvedUrl("Bookmarks.qml")
                pageStack: root.pageStack
            },
            Kirigami.PagePoolAction {
                text: "Settings"
                icon.name: "settings-configure"
                pagePool: appPagePool
                page: Qt.resolvedUrl("Settings.qml")
                pageStack: root.pageStack
            }
        ]
    }
}