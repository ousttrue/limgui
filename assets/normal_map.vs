#version 400
layout(location = 0) in vec3 VertexPosition;
layout(location = 1) in vec3 VertexNormal;
layout(location = 2) in vec2 VertexTexCoord;
layout(location = 3) in vec4 VertexTangent;
uniform mat4 MVP;
uniform mat3 NormalMatrix;

out vec2 TexCoord;
out vec3 Color;

void main() {
  TexCoord = VertexTexCoord;
  Color = vec3(VertexTangent);
  gl_Position = MVP * vec4(VertexPosition, 1.0);
};
