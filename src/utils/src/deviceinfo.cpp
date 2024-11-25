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

#include "deviceinfo.h"
#include <QFile>

const char* CONFIG_FILE = "/etc/asteroid/machine.conf";
const char* HOST_FILE = "/etc/hostname";
const char* OS_RELEASE_FILE = "/etc/os-release";

DeviceInfo::DeviceInfo()
    : m_settings(CONFIG_FILE, QSettings::IniFormat)
{
    QSettings::Status status(m_settings.status());
    if (status == QSettings::FormatError ) {
        qWarning("Configuration file \"%s\" is in wrong format", CONFIG_FILE);
    } else if (status != QSettings::NoError) {
        qWarning("Unable to open \"%s\" configuration file", CONFIG_FILE);
    }

    QFile host(HOST_FILE);
    if (host.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&host);
        in.setEncoding(QStringConverter::Utf8);
        m_hostname = in.readLine();
        host.close();
    }

    QFile release(OS_RELEASE_FILE);
    if (release.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&release);
        in.setEncoding(QStringConverter::Utf8);
        QString line = in.readLine();
        for (bool searching{true}; searching && !in.atEnd(); line = in.readLine()) {
            if (line.startsWith("BUILD_ID")) {
                auto parts = line.split(QLatin1Char('='));
                m_buildid = parts[1];
                m_buildid.remove(QChar('"'));
                searching = false;
            }
        }
        release.close();
    }
}

bool DeviceInfo::hasRoundScreen()
{
    return m_settings.value("Display/ROUND", false).toBool();
}

double DeviceInfo::borderGestureWidth()
{
    return m_settings.value("Display/BORDER_GESTURE_WIDTH", 0.1).toFloat();
}

int DeviceInfo::flatTireHeight()
{
    return m_settings.value("Display/FLAT_TIRE", 0).toInt();
}

bool DeviceInfo::needsBurnInProtection()
{
    return m_settings.value("Display/NEEDS_BURN_IN_PROTECTION", true).toBool();
}

bool DeviceInfo::hasWlan()
{
    return m_settings.value("Capabilities/HAS_WLAN", false).toBool();
}

bool DeviceInfo::hasSpeaker()
{
    return m_settings.value("Capabilities/HAS_SPEAKER", false).toBool();
}

QString DeviceInfo::hostname() const
{
    return m_hostname;
}

QString DeviceInfo::machineName() const
{
    return m_settings.value("Identity/MACHINE", "unknown").toString();
}

QString DeviceInfo::buildID() const
{
    return m_buildid;
}
