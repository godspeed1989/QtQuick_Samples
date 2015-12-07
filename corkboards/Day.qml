import QtQuick 2.5

// Components are reusable, encapsulated QML elements
Component {
    // 显示每一天
    Item { // Item has no visual appearance
        property variant stickies

        id: page
        width: 840; height: 480

        Image { source: "pics/cork.jpg" }

        MouseArea {
            anchors.fill: parent
            onClicked: page.focus = false;
        }

        Text {
            text: datename; x: 15; y: 8; height: 40; width: 370
            font.pixelSize: 18; font.bold: true; color: "white"
            style: Text.Outline; styleColor: "red"
        }

        Repeater {
            model: notes // providing data for the repeater.
            // 逐个处理每个便笺
            Item {
                id: stickyPage

                property int randomX: Math.random() * 500 + 100
                property int randomY: Math.random() * 200 + 50

                x: randomX; y: randomY
                // 轻微晃动效果
                rotation: -flickable.horizontalVelocity / 100;
                Behavior on rotation {
                    SpringAnimation { spring: 2.0; damping: 0.15 }
                }
                // 便笺纸片
                Item {
                    id: sticky
                    scale: 0.7
                    //
                    Image {
                        id: stickyImage
                        x: -150; y: -20; scale: 0.6
                        source: "pics/note-yellow.png"
                        transformOrigin: Item.TopLeft
                        rotation: 8
                        smooth: true
                    }
                    //
                    TextEdit {
                        id: myText
                        text: noteText
                        x: -120; y: 30
                        width: 200; height: 180;
                        font.pixelSize: 24
                        wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere
                        readOnly: false
                        smooth: true

                    }
                }
                // 大头钉
                Image {
                    x: -width / 2; y: -20
                    source: "pics/tack.png"
                    scale: 0.6
                }
                /* 拖放 */
                Item {
                    // 拖放范围
                    x: stickyImage.x; y: stickyImage.y
                    width: stickyImage.width * stickyImage.scale
                    height: stickyImage.height * stickyImage.scale

                    MouseArea {
                        id: mouse
                        anchors.fill: parent
                        drag.target: stickyPage // 针对单个便笺
                        drag.axis: Drag.XandYAxis
                        drag.minimumY: 0
                        drag.maximumY: page.height - 80
                        drag.minimumX: 100
                        drag.maximumX: page.width - 140
                        onClicked: {
                            myText.focus = true
                         }
                    }
                }
                // 鼠标点击事件：放大
                states: State {
                    name: "pressed"
                    when: mouse.pressed
                    PropertyChanges { target: sticky; rotation: 0; scale: 1 }
                }
                transitions: Transition {
                    NumberAnimation { properties: "rotation,scale"; duration: 200 }
                }
            } // notes Item
        } // Repeater
    } // Day Item
} // Component
