#version 400
layout(location = 0) in vec3 VertexPosition;
layout(location = 0) in vec3 VertexNormal;
out vec3 LightIntensity;

uniform mat4 MVP;
uniform vec3 LightDirection = vec3(0, 0, -1);
uniform mat3 NormalMatrix = mat3(1, 0, 0, 0, 1, 0, 0, 0, 1);

void main() {

  vec3 n = normalize(NormalMatrix * VertexNormal);
  LightIntensity = vec3(1, 1, 1) * max(dot(LightDirection, n), 0.0);

  gl_Position = MVP * vec4(VertexPosition, 1.0);
};
