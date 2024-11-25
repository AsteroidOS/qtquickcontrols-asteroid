/*
 * Copyright (C) 2017 - Florent Revest <revestflo@gmail.com>
 * Copyright (C) 2013 - 2014 Jolla Ltd.
 * Contact: Thomas Perl <thomas.perl@jollamobile.com>
 * All rights reserved.
 *
 * This file is part of qml-asteroid
 *
 * You may use this file under the terms of the GNU Lesser General
 * Public License version 2.1 as published by the Free Software Foundation
 * and appearing in the file license.lgpl included in the packaging
 * of this file.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License version 2.1 as published by the Free Software Foundation
 * and appearing in the file license.lgpl included in the packaging
 * of this file.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 */

#include "asteroidapp.h"

#include <QQuickView>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QScreen>
#include <QFileInfo>
#include <MDesktopEntry>
#include <QTranslator>
#if WITH_MAPPLAUNCHERD
#include <mdeclarativecache/MDeclarativeCache>

static QString applicationPath()
{
    QString argv0 = QCoreApplication::arguments()[0];

    if (argv0.startsWith("/")) {
        // First, try argv[0] if it's an absolute path (needed for booster)
        return argv0;
    } else {
        // If that doesn't give an absolute path, use /proc-based detection
        return QCoreApplication::applicationFilePath();
    }
}
#endif

namespace AsteroidApp {
    QString appName()
    {
#if WITH_MAPPLAUNCHERD
        QFileInfo exe = QFileInfo(applicationPath());
#else
        QFileInfo exe = QFileInfo(QCoreApplication::applicationFilePath());
#endif
        return exe.baseName();
    }

    QGuiApplication *application(int &argc, char **argv)
    {
        static QGuiApplication *app = NULL;

        if (app == NULL) {
#if WITH_MAPPLAUNCHERD
            app = MDeclarativeCache::qApplication(argc, argv);
#else
            app = new QGuiApplication(argc, argv);
#endif

            app->setOrganizationName(appName());
            app->setOrganizationDomain(appName());
            app->setApplicationName(appName());

            QTranslator *translator = new QTranslator();
            if (!translator->load(QLocale(), appName(), ".", "/usr/share/translations", ".qm")) {
                qDebug() << "Failed to load" << QLocale().name() << "translations for" << appName();
            }
            app->installTranslator(translator);
        } else {
            qWarning("AsteroidApp::application() called multiple times");
        }

        return app;
    }

    QQuickView *createView()
    {
#if WITH_MAPPLAUNCHERD
        QQuickView *view = MDeclarativeCache::qQuickView();
#else
        QQuickView *view = new QQuickView;
#endif
        MDesktopEntry entry("/usr/share/applications/" + appName() + ".desktop");
        if (entry.isValid()) {
            view->setTitle(entry.name());
        }

        QObject::connect(view->engine(), &QQmlEngine::quit,
                         qApp, &QGuiApplication::quit);

        return view;
    }

    int main(int &argc, char **argv)
    {
        QScopedPointer<QGuiApplication> app(AsteroidApp::application(argc, argv));
        QScopedPointer<QQuickView> view(AsteroidApp::createView());
        view->setSource(QUrl("qrc:/qt/qml/asteroidapp/main.qml"));
        view->resize(app->primaryScreen()->size());
        view->show();
        return app->exec();
    }
};
