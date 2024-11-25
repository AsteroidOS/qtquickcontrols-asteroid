/*
 * Copyright (C) 2015 - Florent Revest <revestflo@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef DEVICEINFO_H
#define DEVICEINFO_H

#include <QObject>
#include <QJSEngine>
#include <QQmlEngine>
#include <QSettings>

class DeviceInfo : public QObject
{
    Q_OBJECT
    QML_SINGLETON
    QML_ELEMENT
    Q_DISABLE_COPY(DeviceInfo)
    Q_PROPERTY(bool hasRoundScreen READ hasRoundScreen CONSTANT)
    Q_PROPERTY(double borderGestureWidth READ borderGestureWidth CONSTANT)
    Q_PROPERTY(int flatTireHeight READ flatTireHeight CONSTANT)
    Q_PROPERTY(bool needsBurnInProtection READ needsBurnInProtection CONSTANT)
    Q_PROPERTY(bool hasWlan READ hasWlan CONSTANT)
    Q_PROPERTY(bool hasSpeaker READ hasSpeaker CONSTANT)
    Q_PROPERTY(QString hostname READ hostname CONSTANT)
    Q_PROPERTY(QString machineName READ machineName CONSTANT)
    Q_PROPERTY(QString buildID READ buildID CONSTANT)
    DeviceInfo();
public:
    static DeviceInfo *create(QQmlEngine *, QJSEngine *)
    {
        return new DeviceInfo;
    }
    bool hasRoundScreen();
    double borderGestureWidth();
    int flatTireHeight();
    bool needsBurnInProtection();
    bool hasWlan();
    bool hasSpeaker();
    QString hostname() const;
    QString machineName() const;
    QString buildID() const;
private:
    QSettings m_settings;
    QString m_hostname;
    QString m_buildid;
};

#endif // DEVICEINFO_H
