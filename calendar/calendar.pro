TEMPLATE = app

QT += qml quick sql
CONFIG += c++11

TARGET = calendar

!contains(sql-drivers, sqlite): QTPLUGIN += qsqlite

SOURCES += \
    event.cpp \
    sqleventmodel.cpp \
    main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    event.h \
    sqleventmodel.h

