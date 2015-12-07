import QtQuick 2.5

Rectangle {
    width: 800; height: 480
    color: "#464646"

    ListModel {
        id: datalist

        ListElement {
            datename: "Sunday"
            notes: [
                ListElement { noteText: "Lunch" },
                ListElement { noteText: "Birthday Party" }
            ]
        }

        ListElement {
            datename: "Monday"
            notes: [
                ListElement { noteText: "Pickup kids from\nschool\n4.30pm" },
                ListElement { noteText: "Checkout Qt" },
                ListElement { noteText: "Read email" }
            ]
        }

        ListElement {
            datename: "Tuesday"
            notes: [
                ListElement { noteText: "Walk dog" },
                ListElement { noteText: "Buy newspaper" }
            ]
        }

        ListElement {
            datename: "Wednesday"
            notes: [ ListElement { noteText: "Cook dinner" } ]
        }

        ListElement {
            datename: "Thursday"
            notes: [
                ListElement { noteText: "Meeting\n5.30pm" },
                ListElement { noteText: "Weed garden" }
            ]
        }

        ListElement {
            datename: "Friday"
            notes: [
                ListElement { noteText: "More work" },
                ListElement { noteText: "Grocery shopping" }
            ]
        }

        ListElement {
            datename: "Saturday"
            notes: [
                ListElement { noteText: "Drink" },
                ListElement { noteText: "Download Qt\nPlay with QML" }
            ]
        }
    }

    ListView {
        id: flickable

        anchors.fill: parent
        focus: true
        highlightRangeMode: ListView.StrictlyEnforceRange
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        model: datalist     // 数据内容
        delegate: Day { }   // 展示方式
    }
}
