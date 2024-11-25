/*
 * Copyright (C) 2017 - Florent Revest <revestflo@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
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
    \qmltype StatusPage
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

    StatusPage {
        text: "On fire"
        icon: "ios-bonfire-outline"
        clickable: true
        onClicked: icon = "ios-bonfire"
    }
    \endqml
*/
Item {
    /*! Text to display */
    property alias text: statusLabel.text
    /*! Icon to display */
    property alias icon: statusIcon.name
    /*! Page is clickable. Default to false */
    property bool clickable: false
    /*! Active background */
    property bool activeBackground: false
    /*! signal emitted when clicked */
    signal clicked()

    anchors.fill: parent

    Rectangle {
        id: statusBackground
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -Dims.h(13)
        color: "black"
        radius: width/2
        opacity: activeBackground ? 0.4 : 0.2
        width: parent.height*0.25
        height: width
    }
    Icon {
        id: statusIcon
        anchors.fill: statusBackground
        anchors.margins: Dims.l(3)
    }
    MouseArea {
        id: statusMA
        enabled: clickable
        anchors.fill: statusBackground
        onClicked: parent.clicked()
    }

    Label {
        id: statusLabel
        font.pixelSize: Dims.l(5)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.Wrap
        anchors.left: parent.left; anchors.right: parent.right
        anchors.leftMargin: Dims.w(4); anchors.rightMargin: anchors.leftMargin
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: Dims.h(15)
    }
}
