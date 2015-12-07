#include "bargraph.h"
#include <QDebug>
#include <QPainter>

void BarGraph::setNumBars(const int numBars)
{
    int i;
    for(i = 0; i < m_bars.size(); i++)
        delete m_bars.at(i);
    m_bars.clear();
    for(i = 0; i < numBars; i++)
        m_bars.push_back(new Bar());
    this->update();
}

void BarGraph::paint(QPainter *painter)
{
    painter->fillRect(rect(), Qt::black);

    const int numBars = m_bars.size();

    QColor barColor(51, 204, 102);
    QColor clipColor(255, 255, 0);

    // Draw the outline
    const QColor gridColor = barColor.darker();
    QPen gridPen(gridColor);
    painter->setPen(gridPen);
    painter->drawLine(rect().topLeft(), rect().topRight());
    painter->drawLine(rect().topRight(), rect().bottomRight());
    painter->drawLine(rect().bottomRight(), rect().bottomLeft());
    painter->drawLine(rect().bottomLeft(), rect().topLeft());

    QVector<qreal> dashes;
    dashes << 2 << 2;
    gridPen.setDashPattern(dashes);
    painter->setPen(gridPen);

    // Draw vertical lines between bars
    if (numBars) {
        const int numVerticalSections = numBars;
        QLineF line(rect().topLeft(), rect().bottomLeft());
        for (int i=1; i<numVerticalSections; ++i) {
            float adx = (float)rect().width() / (float)numVerticalSections;
            line.translate(adx, 0);
            painter->drawLine(line);
        }
    }

    // Draw horizontal lines
    const int numHorizontalSections = 10;
    QLineF line(rect().topLeft(), rect().topRight());
    for (int i=1; i<numHorizontalSections; ++i) {
        float ady = (float)rect().height() / (float)numHorizontalSections;
        line.translate(0, ady);
        painter->drawLine(line);
    }

    barColor = barColor.lighter();
    barColor.setAlphaF(0.75);
    clipColor.setAlphaF(0.75);

    // Draw the bars
    if (numBars) {
        // Calculate width of bars and gaps
        float widgetWidth = rect().width();
        float barPlusGapWidth = widgetWidth / numBars;
        float barWidth = 0.95 * barPlusGapWidth;
        float gapWidth = barPlusGapWidth - barWidth;
        if (gapWidth < 1e-6) gapWidth = 0;
        float leftPaddingWidth = gapWidth / 2.0;
        float gapHeight = 0.5 * gapWidth;
        float barHeight = rect().height() - gapHeight;
        if (barHeight < 1e-6) barHeight = 0;

        for (int i=0; i<numBars; ++i) {
            const qreal value = m_bars[i]->m_value;
            Q_ASSERT(value >= 0.0 && value <= 1.0);
            QRectF bar = rect();
            bar.setLeft(rect().left() + leftPaddingWidth + (i * (gapWidth + barWidth)));
            bar.setWidth(barWidth);
            bar.setTop(rect().top() + gapHeight + (1.0 - value) * barHeight);
            bar.setHeight(value * barHeight);

            QColor color = barColor;
            if (m_bars[i]->m_clipped)
                color = clipColor;

            painter->fillRect(bar, color);
        }
    }
}

void BarGraph::append_bar(QQmlListProperty<Bar> *list, Bar *bar)
{
    BarGraph *graph = qobject_cast<BarGraph*>(list->object);
    if (graph)
    {
        bar->setParentItem(graph);
        graph->m_bars.append(bar);
    }
}

int BarGraph::count_bar(QQmlListProperty<Bar> *list)
{
    BarGraph *graph = qobject_cast<BarGraph*>(list->object);
    if (graph)
    {
        return graph->m_bars.size();
    }
    return 0;
}

Bar* BarGraph::at_bar(QQmlListProperty<Bar> *list, int index)
{
    BarGraph *graph = qobject_cast<BarGraph*>(list->object);
    if (graph && index < graph->m_bars.size())
    {
        return graph->m_bars.at(index);
    }
    return 0;
}

void BarGraph::clear_bar(QQmlListProperty<Bar> *list)
{
    BarGraph *graph = qobject_cast<BarGraph*>(list->object);
    if (graph)
    {
        for (int i = 0; i < graph->m_bars.size(); i++)
            delete graph->m_bars.at(0);
        graph->m_bars.clear();
    }
}
