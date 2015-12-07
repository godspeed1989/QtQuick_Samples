#ifndef SQLEVENTMODEL_H
#define SQLEVENTMODEL_H

#include <QList>
#include <QObject>
#include <QSqlTableModel>

#include "event.h"

class SqlEventModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    SqlEventModel();
    Q_INVOKABLE QList<QObject*> eventsForDate(const QDate &date);
    Q_INVOKABLE bool hasEventsForDate(const QDate &date);
private:
    static void createConnection();
};

#endif
