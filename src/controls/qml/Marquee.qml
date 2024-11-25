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
    \qmltype Marquee
    \inqmlmodule AsteroidControls

    \brief Display text that may be longer than the available space.

    The \l Marquee control shows as much as possible of the string
    initially, then animates it moving to the left until it gets to
    the end of the string.  It then resets to the beginning of the
    string and repeats infinitely.

    Here is a short example:

    \qml
    import QtQuick 2.0
    import org.asteroid.controls 1.0

    Item {
        Marquee {
            text: "The quick brown fox jumps over the lazy dog."
            height: parent.height * 0.3
            width: parent.width * 0.8
            anchors.centerIn: parent
        }
    }
    \endqml
*/
Item {
    id: container
    clip: true

    /*! the text to display */
    property alias text: animatedText.text
    /*! the text \l Font */
    property alias font: animatedText.font
    /*! the text color */
    property alias color: animatedText.color

    function originX() {
        var ret = container.width-animatedText.width
        if(ret > 0) return ret/2
        else        return 0
    }

    function destinationX() {
        var ret = container.width-animatedText.width
        if(ret < 0) return ret
        else        return originX()
    }

    function restartAnimation() {
        animation.stop()
        animation1.from = originX()
        animation1.to = originX()
        animation2.to = destinationX()
        animation.start()
    }

    onWidthChanged: restartAnimation()

    Label {
        id: animatedText
        width: contentWidth
        onWidthChanged: restartAnimation()
        elide: Text.ElideNone
    }

    SequentialAnimation {
        id: animation
        loops: Animation.Infinite

        NumberAnimation {
            id: animation1
            target: animatedText
            property: "x"
            duration: 2000
        }

        NumberAnimation {
            id: animation2
            target: animatedText
            property: "x"
            duration: (animatedText.width)/Dims.w(0.08)
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: animatedText
            property: "x"
            duration: 2000
        }
    }
}

