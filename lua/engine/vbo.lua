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
---@field vbo_ibo any
---@field vao any
---@field vertex_count integer
---@field vertex_stride integer
---@field index_count integer
---@field index_stride integer
M.VBO = {
    ---@param self VertexBuffer
    ---@param attributes VertexAttribute[]
    render = function(self, attributes)
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

            local offset = 0
            for i, attribute in ipairs(attributes) do
                gl.glVertexAttribPointer(
                    attribute.location,
                    attribute.element_count,
                    attribute.element_type,
                    gl.GL_FALSE,
                    self.vertex_stride or 0,
                    ffi.cast("const void*", offset)
                )
                offset = offset + attribute.stride
            end
        end

        -- use vao
        gl.glBindVertexArray(self.vao[0])
        if self.index_count then
            -- with index
            gl.glDrawElements(gl.GL_TRIANGLES, self.index_count, self.index_stride, nil)
        else
            -- without index
            gl.glDrawArrays(gl.GL_TRIANGLES, 0, self.vertex_count)
        end
    end,

    set_vertices = function(self, vertices, vertex_count, vertex_stride)
        gl.glBindBuffer(gl.GL_ARRAY_BUFFER, self.vbo_ibo[0])
        gl.glBufferData(gl.GL_ARRAY_BUFFER, ffi.sizeof(vertices), vertices, gl.GL_STATIC_DRAW)
        self.vertex_count = vertex_count
        self.vertex_stride = vertex_stride
    end,

    set_indices = function(self, indices, index_count, index_stride)
        gl.glBindBuffer(gl.GL_ELEMENT_ARRAY_BUFFER, self.vbo_ibo[1])
        gl.glBufferData(gl.GL_ELEMENT_ARRAY_BUFFER, ffi.sizeof(indices), indices, gl.GL_STATIC_DRAW)
        self.index_count = index_count
        self.index_stride = index_stride_map[index_stride]
    end,
}

M.VBO.create = function(vertices, vertex_count, vertex_stride, indices, index_count, index_stride)
    local vbo_ibo = ffi.new "GLuint[2]"
    gl.glGenBuffers(2, vbo_ibo)

    local buffer = utils.new(M.VBO, {
        vbo_ibo = vbo_ibo,
    })

    buffer:set_vertices(vertices, vertex_count, vertex_stride)
    if indices and index_count then
        buffer:set_indices(indices, index_count, index_stride)
    end

    return buffer
end

return M
