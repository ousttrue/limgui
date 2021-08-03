local ffi = require("ffi")
local utils = require("limgui.utils")
local glfw = require("libs.gl_ffi.glfw")
local M = {}

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

local initialized = false
local gl, glc, glu, glext
local program
local function initialize()
    if initialized then
        return
    end
    initialized = true
    -- glad.gladLoadGL(glfw.getProcAddress)
    local gllib = require("libs.gl_ffi.gl")
    gllib.set_loader(glfw)
    gl, glc, glu, glext = gllib.libraries()

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

    program = glext.glCreateProgram()
    glext.glAttachShader(program, vertex_shader)
    glext.glAttachShader(program, fragment_shader)
    glext.glLinkProgram(program)

    -- local mvp_location = glext.glGetUniformLocation(program, "MVP")
    local vpos_location = glext.glGetAttribLocation(program, "vPos")
    glext.glEnableVertexAttribArray(vpos_location)
    glext.glVertexAttribPointer(vpos_location, 2, glc.GL_FLOAT, glc.GL_FALSE, 8, nil)
end

M.Renderer = {
    render = function(self, width, height)
        initialize()

        --         mat4x4 m, p, mvp;
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
    end,
}
M.Renderer.new = function()
    return utils.new(M.Renderer, {})
end

return M
