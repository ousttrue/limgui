#version 400
layout(location = 0) in vec3 VertexPosition;
layout(location = 1) in vec3 VertexNormal;
layout(location = 2) in vec2 VertexTexCoord;
out vec3 LightIntensity;
out vec2 TexCoord;

uniform mat4 MVP;
uniform vec3 LightDirection = vec3(0, -1, 0);
uniform mat3 NormalMatrix = mat3(1, 0, 0, 0, 1, 0, 0, 0, 1);

void main() {

  vec3 n = normalize(NormalMatrix * VertexNormal);
  LightIntensity = vec3(1, 1, 1) * max(dot(LightDirection, n), 0.0);
  TexCoord = VertexTexCoord;
  gl_Position = MVP * vec4(VertexPosition, 1.0);

};
