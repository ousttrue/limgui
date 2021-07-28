-- port from
--
-- * https://www.glfw.org/docs/latest/quick.html
--
local ffi = require("ffi")

local glfw = require("gl_ffi.glfw")
local glfwc = glfw.glfwc
local imgui_ffi = require("imgui_ffi.mod")
local glad = imgui_ffi.libs.glad

local vertex_shader_text = [[#version 110
attribute vec2 vPos;
void main()
{
    gl_Position = vec4(vPos, 0.0, 1.0);
};
]]

local fragment_shader_text = [[#version 110
void main()
{
    gl_FragColor = vec4(1, 1, 1, 1);
};
]]

local function error_callback(error, description)
    print(string.format("Error: %s\n", description))
end

local function key_callback(window, key, scancode, action, mods)
    if key == glfwc.GLFW_KEY_ESCAPE and action == glfwc.GLFW_PRESS then
        glfw.setWindowShouldClose(window, glfwc.GLFW_TRUE)
    end
end

glfw.setErrorCallback(error_callback)

if glfw.init() == 0 then
    assert(false)
end

glfw.hint(glfwc.GLFW_CONTEXT_VERSION_MAJOR, 2)
glfw.hint(glfwc.GLFW_CONTEXT_VERSION_MINOR, 0)

local window = glfw.Window:__new(640, 480, "Simple example", nil, nil)
if not window then
    glfw.terminate()
    assert(false)
end

window:setKeyCallback(key_callback)

window:makeContextCurrent()
-- glad.gladLoadGL(glfw.getProcAddress)
local gllib = require("gl_ffi.gl")
gllib.set_loader(glfw)
local gl, glc, glu, glext = gllib.libraries()
glfw.swapInterval(1)

-- NOTE: OpenGL error checks have been omitted for brevity

local vertex_buffer = ffi.new("GLuint[1]")
glext.glGenBuffers(1, vertex_buffer)
glext.glBindBuffer(glc.GL_ARRAY_BUFFER, vertex_buffer[0])

-- static const struct
-- {
--     float x, y;
--     float r, g, b;
-- } vertices[3] =
-- {
--     { -0.6f, -0.4f, 1.f, 0.f, 0.f },
--     {  0.6f, -0.4f, 0.f, 1.f, 0.f },
--     {   0.f,  0.6f, 0.f, 0.f, 1.f }
-- };
local vertices = ffi.new("float[3][2]")
-- 0
vertices[0][0] = -0.6
vertices[0][1] = -0.4
-- 1
vertices[1][0] = 0.6
vertices[1][1] = -0.4
-- 2
vertices[2][0] = 0.0
vertices[2][1] = 0.6
glext.glBufferData(glc.GL_ARRAY_BUFFER, ffi.sizeof(vertices), vertices, glc.GL_STATIC_DRAW)

local vertex_shader = glext.glCreateShader(glc.GL_VERTEX_SHADER)
local pp = ffi.new("const char *[1]")
pp[0] = vertex_shader_text
glext.glShaderSource(vertex_shader, 1, pp, nil)
glext.glCompileShader(vertex_shader)

local fragment_shader = glext.glCreateShader(glc.GL_FRAGMENT_SHADER)
pp[0] = fragment_shader_text
glext.glShaderSource(fragment_shader, 1, pp, nil)
glext.glCompileShader(fragment_shader)

local program = glext.glCreateProgram()
glext.glAttachShader(program, vertex_shader)
glext.glAttachShader(program, fragment_shader)
glext.glLinkProgram(program)

-- local mvp_location = glext.glGetUniformLocation(program, "MVP")
local vpos_location = glext.glGetAttribLocation(program, "vPos")
glext.glEnableVertexAttribArray(vpos_location)
glext.glVertexAttribPointer(vpos_location, 2, glc.GL_FLOAT, glc.GL_FALSE, 8, nil)

while not window:shouldClose(window) do
    --         mat4x4 m, p, mvp;

    local width, height = window:getFramebufferSize()
    local ratio = width / height

    gl.glViewport(0, 0, width, height)
    gl.glClear(glc.GL_COLOR_BUFFER_BIT)

    --         mat4x4_identity(m);
    --         mat4x4_rotate_Z(m, m, (float) glfwGetTime());
    --         mat4x4_ortho(p, -ratio, ratio, -1.f, 1.f, 1.f, -1.f);
    --         mat4x4_mul(mvp, p, m);

    glext.glUseProgram(program)
    --         glUniformMatrix4fv(mvp_location, 1, GL_FALSE, (const GLfloat*) mvp);
    gl.glDrawArrays(glc.GL_TRIANGLES, 0, 3)

    window:swapBuffers()
    glfw.pollEvents()
end

glfw.terminate()
