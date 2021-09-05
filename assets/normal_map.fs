#version 400
#extension GL_ARB_shading_language_420pack : enable

layout(binding = 0) uniform sampler2D Tex0;
layout(binding = 1) uniform sampler2D Tex1;
in vec3 LightDir;
in vec3 ViewDir;
in vec2 TexCoord;
in vec3 Debug;
out vec4 FragColor;

void main() {
  vec4 texColor = texture2D(Tex0, TexCoord);
  vec4 normal = texture2D(Tex1, TexCoord);

  // FragColor = vec4(Debug, 1);

  float intensity = max(dot(LightDir, (normal.xyz * 2 - 1)), 0);
  vec3 color = vec3(intensity);
  FragColor = vec4(color, 1);
};
