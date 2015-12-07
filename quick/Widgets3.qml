import QtQuick 2.3
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import com.piegraph 1.0
import com.bargraph 1.0
import com.bargraph.bar 1.0

Item {
    BarGraph {
        id: aBarGraph
        width: parent.width; height: 150
        bars: [
            Bar { value: 0.1 },
            Bar { value: 0.1 },
            Bar { value: 0.1 },
            Bar { value: 0.1 },
            Bar { value: 0.1 }
        ]
    }
    PieGraph {
        id: aPieGraph
        anchors.top: aBarGraph.bottom
        width: parent.width; height: 100
        line_color: "red"
        author.name: "godspeed"
        author.email: "godspeed@gmail.com"
        onGetAuthorInvoked: console.log("onGetAuthorInvoked")
        MouseArea {
            anchors.fill: parent
            onClicked: console.log(aPieGraph.author.name, aPieGraph.author.email)
        }
    }
    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: {
            time.text = Date().toString()
            for(var i = 0; i < aBarGraph.bars.length; i++)
                aBarGraph.bars[i].value = Math.random()
            aBarGraph.update()
            // Dynamic QML Object creation
            var newObject = Qt.createQmlObject('import QtQuick 2.0;'+
                                               'Rectangle {color: "red"; width: 20; height: 20}',
                                               aBarGraph, "dynamicRect");
            newObject.destroy(500);
        }
    }
    Text {
        id: time
        anchors.top: aPieGraph.bottom
    }
}
