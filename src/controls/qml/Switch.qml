/*
 * Copyright (C) 2020 Darrel Griët <idanlcontact@gmail.com>
 * Copyright (C) 2016 Florent Revest <revestflo@gmail.com>
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

import QtQuick 2.5
import org.asteroid.controls 1.0

/*!
    \qmltype Switch
    \inqmlmodule org.asteroid.controls 1.0

    \brief Specializes \l IconButton to provide an on/off toggle.

    The IconButton is a specialization of the \l IconButton that provides 
    an on/off toggle.

    This example shows a blue square centered in the screen with a Switch below it.  When the
    Switch is checked, the square turns green.  When it is unchecked, the square turns red.

    \qml
    import QtQuick 2.9
    import org.asteroid.controls 1.0

    Item {
        anchors.centerIn: parent
        anchors.fill: parent
        Rectangle {
            id: square
            anchors.centerIn: parent
            width: 100
            height: 100
            color: "blue"
        }
        Switch {
            anchors.top: square.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: Dims.l(20)
            onCheckedChanged: { 
                if (checked) 
                    square.color = "green"
                else
                    square.color = "red"
            }
        }
    }
   \endqml
*/
Item {
    property bool checked

    width: Dims.l(30)
    height: width

    Icon {
        id: onIcon
        anchors.fill: parent
        name: "ios-checkmark-circle-outline"
        opacity: checked ? (!enabled ? 0.6 : 1.0) : 0.0
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }
    Icon {
        id: offIcon
        anchors.fill: parent
        name: "ios-circle-outline"
        opacity: !checked ? (!enabled ? 0.6 : 1.0) : 0.0
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: checked = !checked
    }
}
