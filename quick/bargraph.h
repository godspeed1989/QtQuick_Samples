#ifndef BARGRAPH_H
#define BARGRAPH_H

#include <QWidget>
#include <QtQuick/QQuickPaintedItem>

class Bar : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(qreal value MEMBER m_value)
public:
    explicit Bar()
        : QQuickItem(0) , m_value(0.0), m_clipped(false) {}
    Bar(const Bar& bar) : QQuickItem(0)
    {
        m_value = bar.m_value;
        m_clipped = bar.m_clipped;
    }
    Bar& operator = (const Bar &bar)
    {
        m_value = bar.m_value;
        m_clipped = bar.m_clipped;
        return *this;
    }
public:
   qreal m_value;
   bool m_clipped;
};

class BarGraph : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<Bar> bars READ readBars)// DONOT associate WRITE
public:
    explicit BarGraph(QQuickItem *parent = 0)
        : QQuickPaintedItem(parent)
    {
    }
    Q_INVOKABLE void setNumBars(const int numBars);
    void paint(QPainter *painter);
    QRectF rect() const
    {
        return QRectF(0, 0, width(), height());
    }
    QQmlListProperty<Bar> readBars()
    {
        return QQmlListProperty<Bar>(this, 0,
                                     append_bar, count_bar, at_bar, clear_bar);
    }
private:
    QList<Bar*> m_bars;
    static void append_bar(QQmlListProperty<Bar> *list, Bar *bar);
    static int count_bar(QQmlListProperty<Bar> *list);
    static Bar* at_bar(QQmlListProperty<Bar> *list, int index);
    static void clear_bar(QQmlListProperty<Bar> *list);
};

#endif // BARGRAPH_H
