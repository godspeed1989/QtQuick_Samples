#ifndef PIEGRAPH_H
#define PIEGRAPH_H

#include <QtQuick/QQuickPaintedItem>
#include <QtQml>
#include <QPainter>

class Author : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name MEMBER m_name)
    Q_PROPERTY(QString email MEMBER m_email)
public:
    Author(QObject *parent = 0): QObject(parent) {}
    QString m_name, m_email;
    Q_INVOKABLE void printOut()
    {
        qDebug() << "cpp:" << m_name << m_email;
    }
public slots:
    void cppSlot(QString msg)
    {
        qDebug() << "cpp: slot" << msg;
    }
};

extern Author global_author;

class PieGraph : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QColor line_color MEMBER m_color)
    Q_PROPERTY(Author* author READ getAuthor)
public:
    explicit PieGraph(QQuickItem *parent = 0)
        : QQuickPaintedItem(parent), m_author(new Author(this)) {}
private:
    QColor m_color;
    Author *m_author;
signals:
    void getAuthorInvoked();
public:
    Author *getAuthor()
    {
        emit getAuthorInvoked();
        return m_author;
    }
    void paint(QPainter *painter)
    {
        QPen pen(m_color, 2);
        painter->setPen(pen);
        painter->setRenderHints(QPainter::Antialiasing, true);
        painter->drawPie(boundingRect().adjusted(1, 1, -1, -1), 90 * 16, 320 * 16);
    }
};

#endif // PIEGRAPH_H
