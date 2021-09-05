#version 400
uniform mat4 MVP;
uniform mat4 ModelViewMatrix;
uniform mat3 NormalMatrix;
uniform vec3 LightDirection;

layout(location = 0) in vec3 VertexPosition;
layout(location = 1) in vec3 VertexNormal;
layout(location = 2) in vec2 VertexTexCoord;
layout(location = 3) in vec4 VertexTangent;
out vec3 LightDir;
out vec3 ViewDir;
out vec2 TexCoord;
out vec3 Debug;

void main() {
  vec3 normal = normalize(NormalMatrix * VertexNormal);
  vec3 tangent = normalize(NormalMatrix * vec3(VertexTangent));
  vec3 binormal = normalize(cross(normal, tangent)) * VertexTangent.w;
  mat3 toObjectLocal =
      mat3(tangent.x, binormal.x, normal.x, tangent.y, binormal.y, normal.y,
           tangent.z, binormal.z, normal.z);
  vec3 pos = vec3(ModelViewMatrix * vec4(VertexPosition, 1.0));
  LightDir = normalize(toObjectLocal * LightDirection);
  ViewDir = toObjectLocal * normalize(-pos);
  TexCoord = VertexTexCoord;
  Debug = vec3(VertexTangent);

  gl_Position = MVP * vec4(VertexPosition, 1.0);
};
