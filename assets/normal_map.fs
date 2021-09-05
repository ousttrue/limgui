#version 400
#extension GL_ARB_shading_language_420pack : enable
in vec2 TexCoord;
in vec3 Color;
out vec4 FragColor;
layout(binding = 0) uniform sampler2D Tex0;
layout(binding = 1) uniform sampler2D Tex1;

void main() {
  vec4 texColor = texture2D(Tex0, TexCoord);
  vec4 normal = texture2D(Tex1, TexCoord);
  FragColor = normal;
  FragColor = vec4(Color, 1);
};
