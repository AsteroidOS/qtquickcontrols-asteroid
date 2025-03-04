/*
 * Copyright (C) 2016 Florent Revest <revestflo@gmail.com>
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

#ifndef FLATMESH_H
#define FLATMESH_H

#include <QQuickItem>
#include <QSGNode>
#include <QColor>
#include <QVariantAnimation>
#include <QSGMaterial>

// This is the scene graph material used by FlatMesh. It just creates the Shader object and holds values for some of the uniforms
class SGFlatMeshMaterial : public QSGMaterial
{
public:
    // Start the animation at a random point. Disable SceneGraph optimizations that assume our vertex coordinates to be in pixels
    SGFlatMeshMaterial() : m_loopNb(random()) { setFlag(QSGMaterial::RequiresFullMatrix); }
    int compare(const QSGMaterial *other) const override { return 0; }
    void setScreenScaleFactor(float screenScaleFactor) { m_screenScaleFactor = screenScaleFactor; }
    float screenScaleFactor() { return m_screenScaleFactor; }
    void setShiftMix(float shiftMix) { m_shiftMix = shiftMix; }
    float shiftMix() { return m_shiftMix; }
    void setSize(float width, float height) { m_width = width; m_height = height; }
    float width() { return m_width; }
    float height() { return m_height; }
    void incrementLoopNb() { m_loopNb++; }
    int loopNb() { return m_loopNb; }
protected:
    QSGMaterialType *type() const override { static QSGMaterialType type; return &type; }
    QSGMaterialShader *createShader() const override;
private:
    float m_screenScaleFactor;
    float m_shiftMix;
    float m_width;
    float m_height;
    int m_loopNb;
};

struct FlatMeshVertex;

// The QtQuick item per-se, this is the highest level construct that exposes properties to QML
class FlatMesh : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QColor centerColor WRITE setCenterColor READ getCenterColor)
    Q_PROPERTY(QColor outerColor WRITE setOuterColor READ getOuterColor)
    Q_PROPERTY(bool animated WRITE setAnimated READ getAnimated NOTIFY animatedChanged)

public:
    FlatMesh(QQuickItem *parent = 0);

    bool getAnimated() const { return m_animated; }
    void setAnimated(bool animated);

    // As an optimization for color animations, make it possible to change the two colors
    // on one call. Then, updateColors() will only run once saving some CPU cycles
    Q_INVOKABLE void setColors(QColor center, QColor outer);

    QColor getCenterColor() const { return m_centerColor; }
    void setCenterColor(QColor c);

    QColor getOuterColor() const { return m_outerColor; }
    void setOuterColor(QColor c);

signals:
    void animatedChanged();

protected:
    QSGNode *updatePaintNode(QSGNode *node, UpdatePaintNodeData *data);
    void geometryChanged(const QRectF &newGeometry, const QRectF &oldGeometry) override;

private slots:
    void maybeEnableAnimation();
    void updateColors();

private:
    QColor m_centerColor, m_outerColor;
    bool m_animated;
    QVariantAnimation m_animation;
    // Note: the Qt documentation says "It is crucial that [...] interaction with the scene
    // graph happens exclusively on the render thread, primarily during the updatePaintNode()
    // call. The rule of thumb is to only use classes with the "QSG" prefix inside the
    // QQuickItem::updatePaintNode() function."
    // However, no hell broke loose for instantiating these in the FlatMesh constructor so...
    // It doesn't look like we're doing anything nasty here but let's keep an eye on it.
    SGFlatMeshMaterial m_material;
    QSGGeometry m_geometry;
    bool m_geometryDirty;
};

#endif // FLATMESH_H
