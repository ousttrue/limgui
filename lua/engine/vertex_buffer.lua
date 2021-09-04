local ffi = require "ffi"
local gl = require "gl_ffi.mod"
local utils = require "limgui.utils"

local index_stride_map = {
    [1] = gl.GL_UNSIGNED_BYTE,
    [2] = gl.GL_UNSIGNED_SHORT,
    [4] = gl.GL_UNSIGNED_INT,
}

local M = {}
--- Interleaved vertex buffer
---@class VertexBuffer
---@field vao ffi.cdata*
---@field vbo ffi.cdata*
---@field vertex_count integer
---@field vertex_stride integer
---@field ibo ffi.cdata*
---@field index_count integer
---@field index_stride integer
M.VertexBuffer = {
    ---@param self VertexBuffer
    render = function(self, offset, count)
        -- use vao
        gl.glBindVertexArray(self.vao[0])
        if self.ibo then
            -- with index
            gl.glDrawElements(gl.GL_TRIANGLES, count, self.index_stride, ffi.cast("void*", offset))
        else
            -- without index
            gl.glDrawArrays(gl.GL_TRIANGLES, 0, self.vertex_count)
        end
    end,

    set_vertices = function(self, vertices, vertex_count, vertex_stride)
        self.vbo = ffi.new "GLuint[1]"
        gl.glGenBuffers(1, self.vbo)
        gl.glBindBuffer(gl.GL_ARRAY_BUFFER, self.vbo[0])
        gl.glBufferData(gl.GL_ARRAY_BUFFER, ffi.sizeof(vertices), vertices, gl.GL_STATIC_DRAW)
        self.vertex_count = vertex_count
        self.vertex_stride = vertex_stride
    end,

    set_indices = function(self, indices, index_count, index_stride)
        self.ibo = ffi.new "GLuint[1]"
        gl.glGenBuffers(1, self.ibo)
        gl.glBindBuffer(gl.GL_ELEMENT_ARRAY_BUFFER, self.ibo[0])
        gl.glBufferData(gl.GL_ELEMENT_ARRAY_BUFFER, ffi.sizeof(indices), indices, gl.GL_STATIC_DRAW)
        self.index_count = index_count
        self.index_stride = index_stride_map[index_stride]
    end,
}

M.VertexBuffer.create =
    function(vertices, vertex_count, vertex_stride, indices, index_count, index_stride, vertex_attributes)
        -- create vao
        local vao = ffi.new "GLuint[1]"
        gl.glGenVertexArrays(1, vao)

        local buffer = utils.new(M.VertexBuffer, { vao = vao })

        -- setup vao
        gl.glBindVertexArray(vao[0])
        do
            buffer:set_vertices(vertices, vertex_count, vertex_stride)
            for _, attribute in ipairs(vertex_attributes) do
                attribute:activate()
            end

            if indices and index_count then
                buffer:set_indices(indices, index_count, index_stride)
            end
        end
        gl.glBindVertexArray(0)

        return buffer
    end

return M
