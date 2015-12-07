import QtQuick 2.3

Rectangle {
    id: window
    width: 180; height: 200

    ListModel {
        id: fruitModel
        ListElement {
            name: "Apple"
            cost: 2.45
            attributes: [
                ListElement { description: "Core" },
                ListElement { description: "Deciduous" }
            ]
        }
        ListElement {
            name: "Orange"
            cost: 3.25
            attributes: [
                ListElement { description: "Citrus" }
            ]
        }
        ListElement {
            name: "Banana"
            cost: 1.95
            attributes: [
                ListElement { description: "Tropical" },
                ListElement { description: "Seedless" }
            ]
        }
    }

    Component {
        id: fruitDelegate
        Item {
            width: 180; height: 65
            Column {
                anchors.verticalCenter: parent.verticalCenter
                Row {
                    spacing: 5
                    Text { text: name }
                    Text { text: '$' + cost }
                }
                Row {
                    spacing: 5
                    Text { text: "Attributes:" }
                    Repeater {
                        model: attributes
                        Text { text: description }
                    }
                }
            }
            // Double the price when clicked.
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    fruitModel.setProperty(index, "cost", cost * 2)
                }
            }
        }
    }

    Component {
        id: fruitHighlight
        Rectangle { color: "lightsteelblue"; radius: 10 }
    }

    ListView {
        anchors.fill: parent
        model: fruitModel
        delegate: fruitDelegate
        focus: true
        highlight: fruitHighlight
        highlightFollowsCurrentItem: true
    }
}
