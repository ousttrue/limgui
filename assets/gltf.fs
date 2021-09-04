#version 400
in vec3 LightIntensity;
in vec2 TexCoord;

uniform sampler2D Tex0;

void main() {

  vec4 texColor = texture(Tex0, TexCoord);
  gl_FragColor = vec4(LightIntensity, 1) * texColor;
};
