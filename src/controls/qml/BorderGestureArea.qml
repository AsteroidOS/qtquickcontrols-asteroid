/*
 * Copyright (C) 2015 Florent Revest <revestflo@gmail.com>
 *               2014 Aleksi Suomalainen <suomalainen.aleksi@gmail.com>
 *               2013 John Brooks <john.brooks@dereferenced.net>
 * All rights reserved.
 *
 * You may use this file under the terms of BSD license as follows:
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the author nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import QtQuick 2.9
import QtQuick.Window 2.0
import org.asteroid.utils 1.0

/*!
    \qmltype BorderGestureArea
    \inqmlmodule AsteroidControls

    \brief Provides simple gesture support for swiping up, down, left, right.

    A simple example, based on the example for \l Application is shown below.  If
    the user swipes right, the rectangle turns red.  If the user swipes left, 
    the rectangle turns blue.  If the user swipes down, the rectangle turns 
    yellow.  No action is assigned to swipes up.

    \qml
    import QtQuick 2.9
    import org.asteroid.controls 1.0

    Application {
        id: myapp
        centerColor: "#00010B"
        outerColor: "#E044A6"
        rightIndicVisible: true
        bottomIndicVisible: true

        BorderGestureArea {
            id: gestureArea
            anchors.fill: parent
            acceptsRight: true
            acceptsLeft: true
            acceptsDown: true
            onGestureFinished: (gesture) => {
                if (gesture == "right") {
                    square.color = "red"
                }
                else if (gesture == "left") {
                    square.color = "blue"
                }
                else {
                    square.color = "yellow"
                }
            }
        }

        Rectangle {
            id: square
            anchors.centerIn: parent
            color: "yellow"
            width: parent.width * 0.4
            height: parent.height * 0.2
        }
    }
    \endqml

    Also note that it is possible to use a \l BorderGestureArea inside
    other containers.  For example, one could add the following inside
    the \l Rectangle in the example above.  Within the rectangle, swipes up 
    turn the \l Rectangle green and swipes down turn it orange.

    \qml
    BorderGestureArea {
        id: innerGestureArea
        anchors.fill: parent
        acceptsUp: true
        acceptsDown: true
        onGestureFinished: (gesture) => {
            if (gesture == "up") {
                square.color = "green"
            }
            else {
                square.color = "orange"
            }
        }
    }
    \endqml

*/
MouseArea {
    id: root

    property int boundary: width*DeviceInfo.borderGestureWidth
    property bool delayReset

    signal gestureStarted(string gesture)
    signal gestureFinished(string gesture)

    /*!
        True if the current gesture active.
     */
    property bool active: gesture != ""
    /*!
        Describes the current gesture.

        The string is "down", "left", "up" or "right" if the 
        user has gestured.  Otherwise the string is empty.
     */
    property string gesture
    property int value
    property int max
    property real progress: Math.abs(value) / max
    /*!
        True if gesture is left or right.
    */
    property bool horizontal: gesture === "left" || gesture === "right"
    property bool inverted: gesture === "left" || gesture === "up"

    /*!
        Tells the BorderGestureArea to accept right gestures.
     */
    property bool acceptsRight: false
    /*!
        Tells the BorderGestureArea to accept left gestures.
     */
    property bool acceptsLeft: false
    /*!
        Tells the BorderGestureArea to accept down gestures.
     */
    property bool acceptsDown: false
    /*!
        Tells the BorderGestureArea to accept up gestures.
     */
    property bool acceptsUp: false

    // Internal
    property int _mouseStart
    property variant _gestures: ["down", "left", "up", "right"]

    onPressed: (mouse) => {
        if (mouse.x < boundary && acceptsRight) {
            gesture = "right"
            max = width - mouse.x
        } else if (width - mouse.x < boundary && acceptsLeft) {
            gesture = "left"
            max = mouse.x
        } else if (mouse.y < boundary && acceptsDown) {
            gesture = "down"
            max = height - mouse.y
        } else if (height - mouse.y < boundary && acceptsUp) {
            gesture = "up"
            max = mouse.y
        } else {
            mouse.accepted = false
            return
        }

        value = 0
        if (horizontal)
            _mouseStart = mouse.x
        else
            _mouseStart = mouse.y

        gestureStarted(gesture)
    }

    onPositionChanged: (mouse) => {
        var p = horizontal ? mouse.x : mouse.y
        value = Math.max(Math.min(p - _mouseStart, max), -max)
    }

    function reset() {
        gesture = ""
        value = max = 0
        _mouseStart = 0
    }

    onDelayResetChanged: {
        if (!delayReset)
            reset()
    }

    onReleased: {
        gestureFinished(gesture)
        if (!delayReset)
            reset()
    }
}

