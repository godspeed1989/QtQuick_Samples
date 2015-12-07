import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Item {
    visible: true
    anchors.fill: parent

    Rectangle {
        id: rect
        width: 300; height: 50
        color: "lightgreen"
        signal qmlSignal(string msg)
        MouseArea {
            anchors.fill: parent
            onClicked: {
                rect.qmlSignal("Signal from QML")
                global_author.name = "global_name"
                global_author.email = "global_email"
                global_author.printOut()
            }
        }
        objectName: "myRect"
    }
    TabView {
        id: tabView
        anchors.top: rect.bottom
        width: parent.width; height: parent.height - rect.height
        Tab {
            title: "Widgets1"
            Widgets1 {}
        }
        Tab {
            title: "Widgets2"
            Widgets2 {}
        }
        Tab {
            title: "Widgets3"
            Widgets3 {}
        }
    }
    Item {
        function myQmlFunction(msg) {
            console.log(msg)
            return "return from QML"
        }
        objectName: "myMessage"
    }
}
