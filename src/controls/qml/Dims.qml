/*
 * Part of this code is based on QML-Material (https://github.com/papyros/qml-material/)
 * Asteroid Modificatons
 * Copyright (C) 2017 Florent Revest <revestflo@gmail.com>
 * Copyright (C) 2015 Tim Süberkrüb (https://github.com/tim-sueberkrueb)
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014-2015 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.9
import QtQuick.Window 2.2
import org.asteroid.utils 1.0

pragma Singleton

/*!
    \qmltype Dims
    \inqmlmodule AsteroidControls

    \brief Provides access to dimensions relative to a ratio of the screen width/height.

    This singleton provides methods for building a user interface that automatically scales based on
    screen proportions. Use the Dims::w function wherever you need to specify a size relative to
    the screen width, and Dims::h when you need a dimension relative to the height. Dims::l
    provides a ratio of the smallest dimension for smartwatches that could have a screen larger than
    high.

    Here is a short example:

    \qml
    import QtQuick 2.0
    import org.asteroid.controls 1.0

    Rectangle {
        width: Dims.w(80) // 80 % of screen width
        height: Dims.h(50) // 50 % of screen height

        Label {
            text:"A"
            font.pixelSize: Dims.l(20) // 20 % of screen's smallest dimension
        }
    }
    \endqml
*/
QtObject {
    id: units

    /*!
        \qmlmethod real w(real number)
        \brief Returns a dimension that is \a number percent of the screen width.
    */
    function w(number: real): real {
        return (number/100)*Screen.desktopAvailableWidth
    }

    /*!
        \qmlmethod real h(real number)
        \brief Returns a dimension that is \a number percent of the screen height.
    */
    function h(number: real): real {
        return (number/100)*(Screen.desktopAvailableHeight+DeviceInfo.flatTireHeight)
    }

    /*!
        \qmlmethod real l(real number)
        \brief Returns a dimension that is \a number percent of the screen width or height; whichever is smaller.
    */
    function l(number: real): real {
        if(Screen.desktopAvailableWidth > (Screen.desktopAvailableHeight+DeviceInfo.flatTireHeight))
            return h(number)
        else
            return w(number)
    }

    /*!
        \brief The default icon button margin used.
    */
    property real iconButtonMargin: l(3)
    /*!
        \brief The default font size used.
    */
    property real defaultFontSize:  l(7)
}
