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

#ifndef ASTEROIDAPP_H
#define ASTEROIDAPP_H

#include <QtGlobal>

class QGuiApplication;
class QQuickView;

#if defined(ASTEROIDAPP_LIBRARY)
#  define ASTEROIDAPP_EXPORT Q_DECL_EXPORT
#else
#  define ASTEROIDAPP_EXPORT Q_DECL_IMPORT
#endif

namespace AsteroidApp {
    // Simple interface: Get boosted application and view
    ASTEROIDAPP_EXPORT QGuiApplication *application(int &argc, char **argv);
    ASTEROIDAPP_EXPORT QQuickView *createView();

    // Very simple interface: Uses "qrc:/qt/qml/asteroidapp/main.qml" as QML entry point
    ASTEROIDAPP_EXPORT int main(int &argc, char **argv);
};

Q_DECL_EXPORT int main(int argc, char *argv[]);

#endif /* ASTEROIDAPP_H */
