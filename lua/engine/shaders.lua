local ffi = require("ffi")
local gl = require("libs.gl_ffi.mod")
local utils = require("limgui.utils")

local M = {}

local MINIMAL_vs = [[#version 110
attribute vec2 vPos;
void main()
{
    gl_Position = vec4(vPos, 0.0, 1.0);
};
]]

local MINIMAL_fs = [[#version 110
void main()
{
    gl_FragColor = vec4(1, 1, 1, 1);
};
]]

---@class Shader
---@field program any
---@field vpos any
M.Shader = {
    activate = function(self)
        -- set shader
        gl.glUseProgram(self.program)
        -- activate vertex slot
        gl.glEnableVertexAttribArray(self.vpos)
        -- FBO layout
        gl.glVertexAttribPointer(self.vpos, 2, gl.GL_FLOAT, gl.GL_FALSE, 8, nil)
    end,
}
M.Shader.create = function(vs, fs)
    local vertex_shader = gl.glCreateShader(gl.GL_VERTEX_SHADER)
    local pp = ffi.new("const char *[1]")
    pp[0] = vs
    gl.glShaderSource(vertex_shader, 1, pp, nil)
    gl.glCompileShader(vertex_shader)

    local fragment_shader = gl.glCreateShader(gl.GL_FRAGMENT_SHADER)
    pp[0] = fs
    gl.glShaderSource(fragment_shader, 1, pp, nil)
    gl.glCompileShader(fragment_shader)

    local program = gl.glCreateProgram()
    gl.glAttachShader(program, vertex_shader)
    gl.glAttachShader(program, fragment_shader)
    gl.glLinkProgram(program)

    local vpos_location = gl.glGetAttribLocation(program, "vPos")

    return utils.new(M.Shader, {
        program = program,
        vpos = vpos_location,
    })
end

M.create_minimal = function()
    return M.Shader.create(MINIMAL_vs, MINIMAL_fs)
end

return M
