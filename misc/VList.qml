import QtQuick 2.3

Rectangle {
    width: 120
    height: 200
    VisualItemModel {
        id: itemModel

        Rectangle {
            width: view.width; height: view.height
            color: "#ff7f7f"
            Text { text: "Page 1"; font.bold: true; anchors.centerIn: parent }
        }
        Rectangle {
            width: view.width; height: view.height
            color: "lightgreen"
            Text { text: "Page 2"; font.bold: true; anchors.centerIn: parent }
        }
        Rectangle {
            width: view.width; height: view.height
            color: "lightblue"
            Text { text: "Page 3"; font.bold: true; anchors.centerIn: parent }
        }
    }

    ListView {
        id: view
        width: 10; height: 10
        anchors { fill: parent }
        model: itemModel
        preferredHighlightBegin: 0; preferredHighlightEnd: 0
        highlightRangeMode: ListView.StrictlyEnforceRange
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem;
        flickDeceleration: 2000
    }
}
