#version 400
in vec3 LightIntensity;

void main() { gl_FragColor = vec4(LightIntensity, 1); };
