import QtQuick 2.3

Rectangle {
    id: page
    width: 800
    height: 600
    // Hello world文字
    Text {
        id: helloText
        text: "Hello World"
        color: "blue"
        anchors.horizontalCenter: page.horizontalCenter
        font.pointSize: 24; font.bold: true

        /* 点击鼠标产生的动画 */
        MouseArea { id: mouseArea; anchors.fill: parent }
        // 目标状态
        states:
          State {
            name: "down"; when: mouseArea.pressed == true
            PropertyChanges { target: helloText; y: 500; rotation: 360; color: "red" }
        }

        // 动作定义
        transitions: Transition {
            from: ""; to: "down"; reversible: true
            ParallelAnimation {
                NumberAnimation { properties: "y,rotation"; duration: 500; easing.type: Easing.InOutQuad }
                ColorAnimation { duration: 500 }
            }
        }
    }
    // 图像
    Image {
        id: logo
        width: 40
        height: 40
        source: "pics/logo.png"
        x: 0; y: 0
        Behavior on x { SmoothedAnimation { velocity: 200 } }
        Behavior on y { SmoothedAnimation { velocity: 200 } }
    }
    // 颜色挑选
    Grid {
        id: colorPicker
        x: 4; anchors.bottom: page.bottom; anchors.bottomMargin: 4
        rows: 2; columns: 3; spacing: 3

        Cell { cellColor: "red"; onClicked: {
                console.log("cell receive", cellColor)
                helloText.color = cellColor
            }
        }
        Cell { cellColor: "green"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "blue"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "yellow"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "steelblue"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "black"; onClicked: helloText.color = cellColor }
    }
    // 左右滑动列表
    Column {
        id: vlist
        x: 0; y: 60
        VList {}
        Text { text: "<b>VList</b>"; anchors.horizontalCenter: parent.horizontalCenter }
    }
    // 上下选择列表
    Column {
        id: list
        x: vlist.x + vlist.width; y: 60
        List {}
        Text { text: "<b>List</b>"; anchors.horizontalCenter: parent.horizontalCenter }
    }
    // 上下滑动列表
    Column {
        id: spinner
        x: list.x + list.width; y: 60
        Spinner {
            id: spinner_internal
            width: 120; height: 200
            focus: true
            model: 15
            itemHeight: 25
            delegate: Text { font.pixelSize: 25; text: index; height: 25 }
        }
        Text {
            text: "<b>Spinner index: " + spinner_internal.currentIndex + "</b>";
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    // 标签页列表
    TabWidget {
        id: tabs
        x: spinner.x + spinner.width; y: 60
        width: 200; height: 200
        Rectangle {
            property string title: "Red"
            anchors.fill: parent; color: "#e3e3e3"
            Rectangle { anchors.fill: parent; anchors.margins: 5; color: "#ff7f7f" }
        }
        Rectangle {
            property string title: "Green"
            anchors.fill: parent; color: "#e3e3e3"
            Rectangle { anchors.fill: parent; anchors.margins: 5; color: "lightgreen" }
        }
        Rectangle {
            property string title: "Blue"
            anchors.fill: parent; color: "#e3e3e3"
            Rectangle { anchors.fill: parent; anchors.margins: 5; color: "lightblue" }
        }
    }

    // 处理键盘事件
    focus: true
    Keys.onRightPressed: logo.x = (logo.x + logo.width <= width)?logo.x + logo.width:logo.x
    Keys.onLeftPressed: logo.x = (logo.x - logo.width >= 0)?logo.x - logo.width:logo.x
    Keys.onUpPressed: logo.y = (logo.y - logo.height >= 0)?logo.y - logo.height:logo.y
    Keys.onDownPressed: logo.y = (logo.y + logo.height <= height)?logo.y + logo.height:logo.y
}
