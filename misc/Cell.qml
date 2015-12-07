import QtQuick 2.3

Item {
    id: contain
    property alias cellColor: rectangle.color
    property real name: 133.3

    signal clicked(color cellColor)

    width: 40; height: 25

    Rectangle {
        id: rectangle
        border.color: "white"
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("clicked", cellColor, "color picker")
            // 产生点击信号
            contain.clicked(contain.cellColor)
        }
    }
}
