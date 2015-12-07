import QtQuick 2.3
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

Item {
    Flow {
        flow: Flow.TopToBottom
        /* Button */
        Row {
            BusyIndicator {
                running: true
                anchors.verticalCenter: parent.verticalCenter
            }
            Button {
                text: "Button"
                anchors.verticalCenter: parent.verticalCenter
                onClicked: console.log("Button pushed")
            }
        }
        /* CheckBox */
        GroupBox {
            title: "GroupBox"
            Row {
                CheckBox {
                    text: qsTr("Breakfast")
                    checked: true
                }
                CheckBox {
                    text: qsTr("Lunch")
                }
                CheckBox {
                    text: qsTr("Dinner")
                    checked: true
                }
            }
        }
        /* ComboBox */
        ComboBox {
            currentIndex: 2
            width: 200
            model: ListModel {
                id: cbItems
                ListElement { text: "Banana"; color: "Yellow" }
                ListElement { text: "Apple"; color: "Green" }
                ListElement { text: "Coconut"; color: "Brown" }
            }
            onCurrentIndexChanged: console.debug(cbItems.get(currentIndex).text)
        }
        /* Label */
        Label {
            text: "Hello world"
            font.pixelSize: 22
            font.italic: true
            color: "steelblue"
        }
        /* ProgressBar */
        Column {
            ProgressBar {
                id: progressBar
                value: 0.5
            }
            ProgressBar {
                indeterminate: true
            }
        }
        /* RadioButton */
        GroupBox {
            title: "Tab Position"

            Row {
                ExclusiveGroup { id: tabPositionGroup }
                RadioButton {
                    text: "Top"
                    checked: true
                    exclusiveGroup: tabPositionGroup
                }
                RadioButton {
                    text: "Bottom"
                    exclusiveGroup: tabPositionGroup
                }
            }
        }
        /* Slider */
        Slider {
            width: 200
            value: 0.5
            onValueChanged: progressBar.setValue(value)
        }
        /* SpinBox */
        SpinBox {
            id: spinbox
            decimals: 2
            stepSize: 0.01
            maximumValue: 1; minimumValue: 0
            onValueChanged: progressBar.setValue(value)
        }
        /* Switch */
        Row {
            Switch {
                id: sw
                checked: true
                onCheckedChanged: console.log("switch to", sw.checked);
            }
            Switch { checked: false }
        }
        /* TextField */
        RowLayout {
            Text { text: "Name" }
            TextField {
                placeholderText: qsTr("Enter name")
            }
            spacing: 0
            Text { text: "Password" }
            TextField {
                echoMode: TextInput.Password
                selectByMouse: false
            }
        }
    }
}
