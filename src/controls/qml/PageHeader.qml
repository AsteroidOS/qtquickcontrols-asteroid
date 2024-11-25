/*
 * Copyright (C) 2023 - Timo Könnecke <github.com/eLtMosen>
 * Copyright (C) 2017 - Florent Revest <revestflo@gmail.com>
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
import org.asteroid.utils 1.0

/*!
    \qmltype PageHeader
    \inqmlmodule org.asteroid.controls 1.0

    \brief Provides a title on a page.

    This is intended to be used as a title for a settings page.  Note that there should only
    be a single instance on a page; otherwise the titles will all be placed in the same location
    and make it impossible to read either title.

    Here is a short example that puts a purple \l Rectangle on the screen
    and a \l PageHeader at the top of the screen.

    \qml
    import QtQuick 2.9
    import org.asteroid.controls 1.0

    Item {
        PageHeader { text: "Example Page" }
        Rectangle {
            anchors.centerIn: parent
            width: parent.width * 0.5
            height: parent.height * 0.5
            color: "blue"
        }
    }
    \endqml
*/

Item {
    /*! The text to display. */
    property alias text: title.text

    height: Dims.h(20)
    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
                GradientStop { position: 0.2; color: "#dd000000" }
                GradientStop { position: 0.8; color: "#55000000" }
                GradientStop { position: 1.0; color: "#00000000" }
            }
    }

    Label {
        id: title

        height: Dims.h(20)
        anchors.centerIn: parent
        font {
            styleName: "SemiCondensed Light"
            pixelSize: Dims.l(7)
        }
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        leftPadding: DeviceInfo.hasRoundScreen ? Dims.w(25) : 0
        rightPadding: DeviceInfo.hasRoundScreen ? Dims.w(25) : 0
        wrapMode: Text.WordWrap
        maximumLineCount: 2
    }
}
