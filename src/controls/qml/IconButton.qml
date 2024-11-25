/*
 * Copyright (C) 2017 - Florent Revest <revestflo@gmail.com>
 *               2015 - Tim Süberkrüb <tim.sueberkrueb@web.de>
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
    \qmltype IconButton
    \inqmlmodule org.asteroid.controls 1.0

    \brief Provides a virtual button with settable icon.

    This control provides a virtual button which can then be used to 
    do things via the \l MouseArea::clicked signal

    Here is an example which displays a blue square filling the screen and a button at
    the bottom of the screen.  When the button is pressed, the square turns green.

    \qml
    import QtQuick 2.9
    import org.asteroid.controls 1.0

    Rectangle {
        id: square
        color: "blue"
        IconButton {
            iconName: "ios-checkmark-circle-outline"
            anchors { 
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: Dims.iconButtonMargin
            }

            onClicked: {
                square.color = "green"
            }
        }
    }
    \endqml
*/
MouseArea {
    id: iconButton

    /*! Color of the icon */
    property color iconColor: "#FFFFFFFF"
    /*! Color of the icon once pressed*/
    property color pressedIconColor: "#FFFFFFFF"
    /*! The name of the icon */
    property alias iconName: icon.name

    width: Dims.l(20)
    height: width

    Icon {
        id: icon
        name: "ios-circle-outline"
        anchors.fill: parent
        color: pressed ? pressedIconColor : iconColor
        opacity: iconButton.containsPress ? 0.7 : 1.0
    }
}
