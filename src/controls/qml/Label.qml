/*
 * Copyright (C) 2017 Florent Revest <revestflo@gmail.com>
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

import QtQuick 2.9
import org.asteroid.controls 1.0

/*!
   \qmltype Label
   \inqmlmodule org.asteroid.controls 1.0

   \brief Provides a way to get a text label sized for AsteroidOS.

   This is a simple wrapper for \l Text that by default has white text with 
   \l Text::font.pixelSize of \l Dims::defaultFontSize.

   Here is a short example that shows some text in a blue rectangle on a yellow background:

    \qml
    import QtQuick 2.9
    import org.asteroid.controls 1.0

    Rectangle {
        anchors.fill: parent
        color: "yellow"
        Rectangle {
            anchors.centerIn: parent
            width: Dims.w(50)
            height: Dims.h(10)
            color: "blue"

            Label {
                text:"This is a label."
            }
        }
    }
    \endqml

    The result looks like this on a round watch \image labelExample.jpg "label example screen"


*/
Text {
    color: "white"
    font.pixelSize: Dims.defaultFontSize
    elide: Text.ElideRight
    clip: true
}

