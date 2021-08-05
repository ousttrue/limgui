local utils = require("limgui.utils")
local ffi = require("ffi")
local gl = require("libs.gl_ffi.mod")

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

---@class Scene
---@field program any
---@field vertex_count number
M.Scene = {
    render = function(self)
        gl.glUseProgram(self.program)
        --         glUniformMatrix4fv(mvp_location, 1, GL_FALSE, (const GLfloat*) mvp);
        gl.glDrawArrays(gl.GL_TRIANGLES, 0, self.vertex_count)
    end,
}
M.Scene.triangle = function()
    local vertex_buffer = ffi.new("GLuint[1]")
    gl.glGenBuffers(1, vertex_buffer)
    gl.glBindBuffer(gl.GL_ARRAY_BUFFER, vertex_buffer[0])

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
    gl.glBufferData(gl.GL_ARRAY_BUFFER, ffi.sizeof(vertices), vertices, gl.GL_STATIC_DRAW)

    local vertex_shader = gl.glCreateShader(gl.GL_VERTEX_SHADER)
    local pp = ffi.new("const char *[1]")
    pp[0] = vertex_shader_text
    gl.glShaderSource(vertex_shader, 1, pp, nil)
    gl.glCompileShader(vertex_shader)

    local fragment_shader = gl.glCreateShader(gl.GL_FRAGMENT_SHADER)
    pp[0] = fragment_shader_text
    gl.glShaderSource(fragment_shader, 1, pp, nil)
    gl.glCompileShader(fragment_shader)

    local program = gl.glCreateProgram()
    gl.glAttachShader(program, vertex_shader)
    gl.glAttachShader(program, fragment_shader)
    gl.glLinkProgram(program)

    -- local mvp_location = glext.glGetUniformLocation(program, "MVP")
    local vpos_location = gl.glGetAttribLocation(program, "vPos")
    gl.glEnableVertexAttribArray(vpos_location)
    gl.glVertexAttribPointer(vpos_location, 2, gl.GL_FLOAT, gl.GL_FALSE, 8, nil)

    return utils.new(M.Scene, {
        program = program,
        vertex_count = 3,
    })
end

return M
