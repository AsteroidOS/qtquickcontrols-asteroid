#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(binding = 1) uniform sampler2D source;
void main(void)
{
    vec4 sourceColor = texture(source, qt_TexCoord0);
    float alpha = 1.0;
    if(qt_TexCoord0.y < 0.2)
        alpha = qt_TexCoord0.y*5.0;
    if(qt_TexCoord0.y > 0.8)
        alpha = (1.0-qt_TexCoord0.y)*5.0;
    fragColor = sourceColor * alpha;
}
