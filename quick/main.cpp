#include <QApplication>
#include <QGuiApplication>
#include <QQuickView>
#include <QQmlProperty>
#include <QVBoxLayout>
#include <QWidget>
#include <QPushButton>
#include "piegraph.h"
#include "bargraph.h"

QObject* findObject(QObject *rootObject, const QString &name)
{
    return rootObject->findChild<QObject*>(name);
}

QObject* findObject(const QList<QObject*> &rootObjects, const QString &name)
{
    QObject *ret;
    for (int i = 0, size = rootObjects.size(); i < size; i++)
    {
        ret = rootObjects.at(i);
        if (ret->objectName() == name)
            break;
        ret = rootObjects.at(i)->findChild<QObject*>(name);
        if (ret)
            break;
    }
    return ret;
}

Author global_author;

#define embedded 0

int main(int argc, char *argv[])
{
#if embedded
    QApplication app(argc, argv);
#else
    QGuiApplication app(argc, argv);
#endif
    qmlRegisterType<PieGraph>("com.piegraph", 1, 0, "PieGraph");
    qmlRegisterType<Author>("com.author", 1, 0, "Author");
    qmlRegisterType<BarGraph>("com.bargraph", 1, 0, "BarGraph");
    qmlRegisterType<Bar>("com.bargraph.bar", 1, 0, "Bar");

    QQuickView view;
    view.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
    view.resize(600, 480);
#if embedded
    QWidget *Window = new QWidget();
    QVBoxLayout *layout = new QVBoxLayout(Window);
    QPushButton *button = new QPushButton("ok");
    QObject::connect(button, SIGNAL(clicked(bool)), qApp, SLOT(quit()));
    //
    QWidget *container = QWidget::createWindowContainer(&view, Window);
    container->setFocusPolicy(Qt::TabFocus);
    //
    layout->addWidget(container);
    layout->addWidget(button);
    Window->resize(600, 480);
    Window->show();
#else
    view.show();
#endif

    // export C++ object to QML context
    view.engine()->rootContext()->setContextProperty("global_author", &global_author);

    /* C++ Control QML */
    /* Not very useful */
    // Get Root Object
    QObject *object;
    QObject *rootObject = view.rootObject();
    // Modify Variable
    qDebug() << "---------- C++ access QML property ----------";
    object = findObject(rootObject, "myRect");
    QQmlProperty(object, "width").write(500);
    qDebug() << "cpp:" << object << QQmlProperty(object, "width").read().toInt() ;
    // Call QML function
    qDebug() << "---------- C++ invoke QML method ----------";
    object = findObject(rootObject, "myMessage");
    QVariant returnedValue;
    QVariant msg = "Hello from C++";
    qDebug() << "cpp:" << object;
    QMetaObject::invokeMethod(object, "myQmlFunction",
            Q_RETURN_ARG(QVariant, returnedValue),
            Q_ARG(QVariant, msg));
    qDebug() << "cpp:" << returnedValue.toString();
    // Bind QML signal
    qDebug() << "---------- C++ bind QML's signal ----------";
    object = findObject(rootObject, "myRect");
    qDebug() << "cpp:" << object;
    QObject::connect(object, SIGNAL(qmlSignal(QString)),
                     &global_author, SLOT(cppSlot(QString)));
    qDebug() << "-----------------------";

    return app.exec();
}
