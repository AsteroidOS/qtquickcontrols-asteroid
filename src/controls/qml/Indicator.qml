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
    \qmltype Indicator
    \inqmlmodule AsteroidControls

    \brief Edge indicator for AsteroidOS.

    The Indicator appears in one of four edges: top, right, 
    bottom or left as a small diamond shape.  On loading it is
    animated and, depending on the setting of \l keepExpanded,
    either expands and then recedes into the edge or stays 
    expanded.
   
    In this simple example, one \l Indicator is at the top and 
    stays expanded, while another at the right does not.

    \qml
    import QtQuick 2.9
    import org.asteroid.controls 1.0

    Item {
        Indicator {
            keepExpanded: true
        }
        Indicator {
            edge: Qt.RightEdge
        }
    }
    \endqml

    While the intent of the indicator is to show something 
    to lead the user to additional content or screens of some kind,
    it is also technically possible to use an \l Indicator within
    other objects.  Here, a centered orange \l Rectangle has 
    \l Indicator objects embedded on two of its edges.  This code
    fragment can be inserted into the above example just before the
    final closing brace for a complete example.

    \qml
    Rectangle {
        color: "orange"
        anchors.centerIn: parent
        width: parent.width * 0.5
        height: parent.height * 0.5
        Indicator {
            edge: Qt.BottomEdge
        }
        Indicator {
            edge: Qt.LeftEdge
            keepExpanded: true
        }
    }
    \endqml
*/
Item {
    /*! which edge the indicator attaches to */
    property int edge: Qt.TopEdge
    /*! If true, keep the indicator expanded */
    property bool keepExpanded: false

    function animate() {
        offsetHigh = 0.8*finWidth
        bodyWidthAnim.restart()
        fishOffsetAnim.restart()
        bodyOpacityAnim.restart()
    }

    function animateFar() {
        offsetHigh = 2*finWidth
        bodyWidthAnim.restart()
        fishOffsetAnim.restart()
        bodyOpacityAnim.restart()
    }

    id: fish
    width: body.width
    height: body.height
    anchors.verticalCenter: {
        if(edge === Qt.LeftEdge || edge === Qt.RightEdge) return parent.verticalCenter
        else if(edge === Qt.TopEdge)                      return parent.top
        else                                              return parent.bottom
    }
    anchors.horizontalCenter: {
        if(edge === Qt.TopEdge || edge === Qt.BottomEdge) return parent.horizontalCenter
        else if(edge === Qt.RightEdge)                    return parent.right
        else                                              return parent.left
    }
    rotation: {
        if(edge === Qt.RightEdge)    return 45
        else if(edge === Qt.TopEdge) return -45
        else if(edge== Qt.LeftEdge)  return -135
        else                         return 135
    }

    property real finWidth: Dims.l(1.5)
    property real bodyWidthLow: Dims.l(1.8)
    property real bodyWidthHigh: 2*finWidth
    property real bodyOpacityLow: 0.6
    property real bodyOpacityHigh: 0.8
    property real offsetLow: 0
    property real offsetHigh: 2*finWidth

    Component.onCompleted: animate()

    onKeepExpandedChanged: {
        if(keepExpanded) {
            bodyWidthLow = bodyWidthHigh
            bodyOpacityLow = bodyOpacityHigh
            offsetLow = offsetHigh
        } else {
            bodyWidthLow = Dims.l(1.8)
            bodyOpacityLow = 0.6
            offsetLow = 0
        }
        animate()
    }

    SequentialAnimation {
        id: fishOffsetAnim
        running: false
        NumberAnimation {
            target: fish
            property:  {
                if(edge === Qt.TopEdge || edge === Qt.BottomEdge) return "anchors.verticalCenterOffset"
                else                                              return "anchors.horizontalCenterOffset"
            }
            to: {
                if(edge === Qt.TopEdge || edge === Qt.LeftEdge) return offsetHigh
                else                                            return -offsetHigh
            }
            duration: 300
        }
        NumberAnimation {
            target: fish
            property: {
                if(edge === Qt.TopEdge || edge === Qt.BottomEdge) return "anchors.verticalCenterOffset"
                else                                              return "anchors.horizontalCenterOffset"
            }
            to: offsetLow
            duration: 400
        }
    }

    Rectangle {
        id: body
        width: bodyWidthLow
        height: width
        color: Qt.rgba(215, 215, 215)
        opacity: bodyOpacityLow

        SequentialAnimation {
            id: bodyWidthAnim
            running: false
            NumberAnimation {
                target: body
                property: "width"
                to: bodyWidthHigh
                duration: 300
            }
            NumberAnimation {
                target: body
                property: "width"
                to: bodyWidthLow
                duration: 400
            }
        }

        SequentialAnimation {
            id: bodyOpacityAnim
            running: false
            NumberAnimation {
                target: body
                property: "opacity"
                to: bodyOpacityHigh
                duration: 300
            }
            NumberAnimation {
                target: body
                property: "opacity"
                to: bodyOpacityLow
                duration: 400
            }
        }
    }
}
