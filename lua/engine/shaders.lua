local ffi = require("ffi")
local gl = require("libs.gl_ffi.mod")
local utils = require("limgui.utils")

local M = {}

M.MINIMAL_vs = [[#version 110
attribute vec2 vPos;
void main()
{
    gl_Position = vec4(vPos, 0.0, 1.0);
};
]]

M.MINIMAL_fs = [[#version 110
void main()
{
    gl_FragColor = vec4(1, 1, 1, 1);
};
]]

M.MVP_vs = [[#version 110
uniform mat4 MVP;
attribute vec3 vCol;
attribute vec2 vPos;
varying vec3 color;
void main()
{
    gl_Position = MVP * vec4(vPos, 0.0, 1.0);
    color = vCol;
};
]]

M.MVP_fs = [[#version 110
varying vec3 color;
void main()
{
    gl_FragColor = vec4(color, 1.0);
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

M.create = function(name)
    local vs_name = name .. "_vs"
    local fs_name = name .. "_fs"
    return M.Shader.create(M[vs_name], M[fs_name])
end

return M
