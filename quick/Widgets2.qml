import QtQuick 2.3
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Item {
    SplitView {
        id: splitView
        orientation: Qt.Horizontal
        Calendar {
            id: calender
            weekNumbersVisible: true
        }
        TextArea {
            id: editor
            width: 240
            text:
                "Lorem ipsum dolor sit amet, consectetur adipisicing elit, " +
                "sed do eiusmod tempor incididunt ut labore et dolore magna " +
                "aliqua. Ut enim ad minim veniam, quis nostrud exercitation " +
                "ullamco laboris nisi ut aliquip ex ea commodo cosnsequat. ";
            menu: Menu {
                MenuItem {
                    text: "Select All"
                    shortcut: "Ctrl+A"
                    onTriggered: editor.selectAll()
                }
            }
        }
    }
}
