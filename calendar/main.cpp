#include <QtQml>

#include <QGuiApplication>
#include "sqleventmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<SqlEventModel>("org.qtproject.examples.calendar", 1, 0, "SqlEventModel");
    QQmlApplicationEngine engine(QUrl("qrc:/main.qml"));
    return app.exec();
}
