local ffi = require "ffi"
local gl = require "gl_ffi.mod"
local utils = require "limgui.utils"

local M = {}
---@class VertexBuffer
---@field vbo any
---@field vertex_count number
M.VBO = {
    ---@param self VertexBuffer
    render = function(self)
        gl.glBindBuffer(gl.GL_ARRAY_BUFFER, self.vbo[0])
        gl.glDrawArrays(gl.GL_TRIANGLES, 0, self.vertex_count)
    end,

    set_vertices = function(self, vertices, vertex_count)
        gl.glBindBuffer(gl.GL_ARRAY_BUFFER, self.vbo[0])
        gl.glBufferData(gl.GL_ARRAY_BUFFER, ffi.sizeof(vertices), vertices, gl.GL_STATIC_DRAW)
        self.vertex_count = vertex_count
    end,
}

M.VBO.create = function(vertices, vertex_count)
    local vbo = ffi.new "GLuint[1]"
    gl.glGenBuffers(1, vbo)
    local buffer = utils.new(M.VBO, {
        vbo = vbo,
    })
    buffer:set_vertices(vertices, vertex_count)
    return buffer
end

return M
