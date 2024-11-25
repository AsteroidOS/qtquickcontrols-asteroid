/*
 * Copyright (C) 2023 - Timo Könnecke <github.com/eLtMosen>
 * Copyright (C) 2022 - Ed Beroset <github.com/beroset>
 * Copyright (C) 2020 - Darrel Griët <idanlcontact@gmail.com>
 * Copyright (C) 2015 - Florent Revest <revestflo@gmail.com>
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
    \qmltype LabeledSwitch
    \inqmlmodule org.asteroid.controls 1.0

    \brief This combines \l Label and \l Switch in a convenient package.

    This example shows a centered blue square and a \l LabeledSwitch centered below it.
    The square turns green when the toggle is checked, and red when it is unchecked.

    \qml
    import QtQuick 2.9
    import org.asteroid.controls 1.0

    Item {
        anchors.fill: parent
        Rectangle {
            id: square
            anchors.centerIn: parent
            width: 100
            height: 100
            color: "blue"
        }
        LabeledSwitch {
            anchors.top: square.bottom
            anchors.horizontalCenter: square.horizontalCenter
            width: Dims.l(80)
            height: Dims.l(20)
            text: "Enable"
            checked: false
            onCheckedChanged: {
                if (checked) {
                    square.color = "green"
                } else { 
                    square.color = "red"
                }
            }
        }
    }

    \endqml
*/
Item {
    /*! alias to receive string toggle.checked */
    property alias checked: toggle.checked
    /*! alias to receive string label.text */
    property alias text: label.text
    /*! left and right margin for the row content */
    property int rowMargin: Dims.w(15)
    /*! size of the icon/s */
    property int iconSize: Dims.l(20)
    /*! size of the label text */
    property int labelFontSize: Dims.l(6)

    /*! default width is parent width */
    width: parent.width
    /*! default height is parent height */
    height: parent.height

    Behavior on opacity {
        NumberAnimation {
            duration: 200;
            easing.type: Easing.OutQuad
        }
    }

    Label {
        id: label

        anchors {
            left: parent.left
            leftMargin: rowMargin
            right: toggle.left
            rightMargin: Dims.h(4)
        }
        text: value
        font.pixelSize: labelFontSize
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.Wrap
        height: parent.height
    }

    Switch {
        id: toggle

        anchors {
            right: parent.right
            rightMargin: rowMargin
            verticalCenter: parent.verticalCenter
        }
        height: iconSize
        width: height
    }

    HighlightBar {
        onClicked: toggle.checked = !toggle.checked
    }
}
