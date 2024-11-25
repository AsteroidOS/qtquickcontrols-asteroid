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
    \qmltype Spinner
    \inqmlmodule AsteroidControls

    \brief Simple spinner to select values from collection.

    Here is a short that shows a \l Spinner containing three items
    and using a \l SpinnerDelegate to display them.

    \qml
    import QtQuick 2.0
    import org.asteroid.controls 1.0

    Spinner {
        id: rating
        model: ["Larry", "Moe", "Curly"]
        delegate: SpinnerDelegate{
            text: rating.model[index]
            MouseArea {
                anchors.fill: parent
                onClicked: rating.currentIndex = index
            }
        }
        highlight: Rectangle { color: "orange" }
        highlightFollowsCurrentItem: true
        focus: true
    }
    \endqml
*/
ListView {
    property alias showSeparator: separator.visible

    id: lv
    preferredHighlightBegin: height / 2 - Dims.h(5)
    preferredHighlightEnd: height / 2 + Dims.h(5)
    highlightRangeMode: ListView.StrictlyEnforceRange
    spacing: Dims.h(2)
    clip: true

    delegate: SpinnerDelegate { }

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
