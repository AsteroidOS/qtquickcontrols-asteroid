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
    \qmltype CircularSpinner
    \inqmlmodule AsteroidControls

    \brief A simplified vertical circular spinner, handy for selecting values.

    Creating a vertical spinner to allow the user to select a value from a 
    list is simple with \l CircularSpinner.  A short example is shown below.
    By default, it uses the current index as the data value and pads the number 
    to two digits.  This is particularly convenient for setting times and dates

    \qml
    import QtQuick 2.9
    import org.asteroid.controls 1.0

    CircularSpinner {
        id: rating
        anchors.centerIn: parent
        width: parent.width * 0.5
        height: parent.height
        model: 10
    }
    \endqml

    A slightly more complex version uses a \l SpinnerDelegate to allow
    a user to select an animal.

    \qml
    import QtQuick 2.9
    import org.asteroid.controls 1.0

    CircularSpinner {
        id: animals
        anchors.centerIn: parent
        width: parent.width * 0.5
        height: parent.height
        model: 6
        delegate: SpinnerDelegate{
            text: ["aardvark", "bear", "camel", "dog", "elephant", "fox"][index]
        }
    }
    \endqml
*/
PathView {
    /*!
        Show a visible separator to the right of this spinner.
    */
    property alias showSeparator: separator.visible

    id: pv
    preferredHighlightBegin: 0.5
    preferredHighlightEnd: 0.5
    highlightRangeMode: PathView.StrictlyEnforceRange
    highlightMoveDuration: 0
    clip: true

    delegate: SpinnerDelegate { }

    path: Path {
        startX: pv.width/2; startY: pv.height/2-pv.model*Dims.h(6)
        PathLine { x: pv.width/2; y: pv.height/2+pv.model*Dims.h(6) }
    }

    Rectangle {
        id: separator
        width: 1
        height: parent.height*0.8
        color: "#88FFFFFF"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        visible: false
    }

    layer.enabled: true
    layer.effect: ShaderEffect {
        fragmentShader: "Spinner.frag.qsb"
    }
}
