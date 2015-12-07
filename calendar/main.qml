import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.1
import org.qtproject.examples.calendar 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 400
    minimumWidth: 400
    minimumHeight: 300

    title: "Calendar Example"

    SystemPalette {
        id: systemPalette
    }

    SqlEventModel {
        id: eventModel
    }

    Flow {
        id: row
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10
        layoutDirection: Qt.LeftToRight

        Calendar {
            id: calendar
            width: (parent.width > parent.height ? parent.width * 0.6 - parent.spacing : parent.width)
            height: (parent.height > parent.width ? parent.height * 0.6 - parent.spacing : parent.height)
            frameVisible: true
            weekNumbersVisible: true
            selectedDate: new Date(2014, 0, 1)
            focus: true

            style: CalendarStyle {
                dayDelegate: Item {
                    readonly property color sameMonthDateTextColor: "#444"
                    readonly property color selectedDateColor: "#3778d0"
                    readonly property color selectedDateTextColor: "white"
                    readonly property color differentMonthDateTextColor: "#bbb"
                    readonly property color invalidDatecolor: "#dddddd"

                    Rectangle {
                        anchors.fill: parent
                        border.color: "transparent"
                        color: styleData.date !== undefined && styleData.selected ? selectedDateColor : "transparent"
                        anchors.margins: styleData.selected ? -1 : 0
                    }

                    Image {
                        visible: eventModel.hasEventsForDate(styleData.date)
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.margins: -1
                        width: 12
                        height: width
                        source: "qrc:/images/eventindicator.png"
                    }

                    Label {
                        id: dayDelegateText
                        text: styleData.date.getDate()
                        anchors.centerIn: parent
                        color: {
                            var color = invalidDatecolor;
                            if (styleData.valid) {
                                // Date is within the valid range.
                                color = styleData.visibleMonth ? sameMonthDateTextColor : differentMonthDateTextColor;
                                if (styleData.selected) {
                                    color = selectedDateTextColor;
                                }
                            }
                            color;
                        }
                    }
                }
            }
        }
        // Event List Header
        Component {
            id: eventListHeader

            Row {
                id: eventDateRow
                width: parent.width
                height: eventDayLabel.height
                spacing: 10

                Label {
                    id: eventDayLabel
                    text: calendar.selectedDate.getDate()
                    font.pointSize: 35
                }

                Column {
                    height: eventDayLabel.height

                    Label {
                        readonly property var options: { weekday: "long" }
                        text: Qt.locale().standaloneDayName(calendar.selectedDate.getDay(), Locale.LongFormat)
                        font.pointSize: 18
                    }
                    Label {
                        text: Qt.locale().standaloneMonthName(calendar.selectedDate.getMonth())
                              + calendar.selectedDate.toLocaleDateString(Qt.locale(), " yyyy")
                        font.pointSize: 12
                    }
                }
            }
        }
        // Event List View
        Rectangle {
            width: (parent.width > parent.height ? parent.width * 0.4 - parent.spacing : parent.width)
            height: (parent.height > parent.width ? parent.height * 0.4 - parent.spacing : parent.height)
            border.color: Qt.darker(color, 1.2)

            ListView {
                id: eventsListView
                spacing: 4
                header: eventListHeader
                anchors.fill: parent
                anchors.margins: 10
                model: eventModel.eventsForDate(calendar.selectedDate)

                delegate: Rectangle {
                    width: eventsListView.width
                    height: eventItemColumn.height
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        anchors.top: parent.top
                        anchors.topMargin: 4
                        width: 12
                        height: width
                        source: "qrc:/images/eventindicator.png"
                    }

                    Column {
                        id: eventItemColumn
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.right: parent.right
                        height: startDateLabel.height
                                + endDateLabel.height
                                + nameLabel.height + 8
                        Label {
                            id: nameLabel
                            width: parent.width
                            wrapMode: Text.Wrap
                            text: modelData.name
                        }
                        Label {
                            id: startDateLabel
                            width: parent.width
                            wrapMode: Text.Wrap
                            text: modelData.startDate.toLocaleTimeString(calendar.locale, Locale.ShortFormat)
                        }
                        Label {
                            id: endDateLabel
                            width: parent.width
                            wrapMode: Text.Wrap
                            text: modelData.endDate.toLocaleTimeString(calendar.locale, Locale.ShortFormat)
                        }
                    }
                }
            }
        }
    }
}
