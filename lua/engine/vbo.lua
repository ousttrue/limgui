local ffi = require "ffi"
local gl = require "gl_ffi.mod"
local utils = require "limgui.utils"

local M = {}
--- Interleaved vertex buffer
---@class VertexBuffer
---@field vbo_ibo any
---@field vao any
---@field vertex_count number
---@field index_count number
M.VBO = {
    ---@param self VertexBuffer
    render = function(self)
        if not self.vao then
            -- create vao
            local vao = ffi.new "GLuint[1]"
            gl.glGenVertexArrays(1, vao)
            self.vao = vao
            -- setup vao
            gl.glBindVertexArray(self.vao[0])
            gl.glBindBuffer(gl.GL_ARRAY_BUFFER, self.vbo_ibo[0])
            if self.index_count then
                gl.glBindBuffer(gl.GL_ELEMENT_ARRAY_BUFFER, self.vbo_ibo[1])
            end
            -- position
            gl.glEnableVertexAttribArray(0)
            gl.glVertexAttribPointer(0, 3, gl.GL_FLOAT, gl.GL_FALSE, 0, nil)
        end

        -- use vao
        gl.glBindVertexArray(self.vao[0])
        if self.index_count then
            -- with index
            gl.glDrawElements(gl.GL_TRIANGLES, self.index_count, gl.GL_UNSIGNED_INT, nil)
        else
            -- without index
            gl.glDrawArrays(gl.GL_TRIANGLES, 0, self.vertex_count)
        end
    end,

    set_vertices = function(self, vertices, vertex_count)
        gl.glBindBuffer(gl.GL_ARRAY_BUFFER, self.vbo_ibo[0])
        gl.glBufferData(gl.GL_ARRAY_BUFFER, ffi.sizeof(vertices), vertices, gl.GL_STATIC_DRAW)
        self.vertex_count = vertex_count
    end,

    set_indices = function(self, indices, index_count)
        gl.glBindBuffer(gl.GL_ELEMENT_ARRAY_BUFFER, self.vbo_ibo[1])
        gl.glBufferData(gl.GL_ELEMENT_ARRAY_BUFFER, ffi.sizeof(indices), indices, gl.GL_STATIC_DRAW)
        self.index_count = index_count
    end,
}

M.VBO.create = function(vertices, vertex_count, indices, index_count)
    local vbo_ibo = ffi.new "GLuint[2]"
    gl.glGenBuffers(2, vbo_ibo)

    local buffer = utils.new(M.VBO, {
        vbo_ibo = vbo_ibo,
    })
    buffer:set_vertices(vertices, vertex_count)
    if indices and index_count then
        buffer:set_indices(indices, index_count)
    end
    return buffer
end

return M
