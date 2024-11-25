/*
 * Copyright (C) 2017 Florent Revest <revestflo@gmail.com>
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

#include "icon.h"

#include <QPainter>
#include <QIcon>
#include <QSvgRenderer>
#include <QFile>

#define ICONS_DIRECTORY "/usr/share/icons/asteroid/"

Icon::Icon()
{
    setFlag(ItemHasContents, true);
    setRenderTarget(QQuickPaintedItem::FramebufferObject);
    m_color = Qt::white;
}

void Icon::updateBasePixmap()
{
    m_pixmap = QPixmap(QSize(width(), height()));
}

void Icon::updatePixmapContent()
{
    if(m_pixmap.isNull())
        return;

    m_pixmap.fill(Qt::transparent);

    if(!QFile::exists(ICONS_DIRECTORY + m_name + ".svg"))
        return;

    QPainter painter(&m_pixmap);
    QSvgRenderer svgRenderer(ICONS_DIRECTORY + m_name + ".svg");
    svgRenderer.render(&painter);
}

void Icon::updatePixmapColor()
{
    if(m_pixmap.isNull())
        return;

    QPainter painter(&m_pixmap);
    painter.setCompositionMode(QPainter::CompositionMode_SourceIn);
    painter.fillRect(QRect(0, 0, width(), height()), m_color);
}

void Icon::paint(QPainter *painter)
{
    if(m_pixmap.isNull())
        return;
    painter->drawPixmap(0, 0, width(), height(), m_pixmap);
}


void Icon::geometryChange(const QRectF &newGeometry, const QRectF &oldGeometry)
{
    QQuickPaintedItem::geometryChange(newGeometry, oldGeometry);
    if(newGeometry.size() == oldGeometry.size() || newGeometry.width() == 0 || newGeometry.height() == 0)
        return;
    updateBasePixmap();
    updatePixmapContent();
    updatePixmapColor();
    update();
}

QString Icon::name()
{
    return m_name;
}

void Icon::setName(QString name)
{
    if(m_name == name)
        return;

    m_name = name;

    updatePixmapContent();
    updatePixmapColor();
    update();
    emit nameChanged();
}

QColor Icon::color()
{
    return m_color;
}

void Icon::setColor(QColor color)
{
    if(m_color == color)
        return;

    m_color = color;

    updatePixmapColor();
    update();
    emit colorChanged();
}
