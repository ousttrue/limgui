local utils = require "limgui.utils"
local ffi = require "ffi"

local vertex_layout = require "scene.vertex_layout"

local M = {}

---@class SceneMesh
---@field vertices any
---@field vertex_count integer
---@field vertex_stride integer
---@field indices any
---@field index_count integer
---@field index_stride integer
---@field shader string|table
---@field layout VertexLayout[]
M.SceneMesh = {}

M.SceneMesh.triangle = function()
    local vertices = ffi.new "float[3][2]"
    -- 0
    vertices[0][0] = -0.6
    vertices[0][1] = -0.4
    -- 1
    vertices[1][0] = 0.6
    vertices[1][1] = -0.4
    -- 2
    vertices[2][0] = 0.0
    vertices[2][1] = 0.6

    return utils.new(M.SceneMesh, {
        vertices = vertices,
        vertex_count = 3,
        shader = "MINIMAL",
        layout = vertex_layout.VertexLayout.new {},
    })
end

--- create vertex buffer
--- TODO: layout
---@param vertices any
---@param vertex_count any
---@param vertex_stride any
---@param indices any
---@param index_count any
---@param index_stride any
---@return table<string, any>
M.SceneMesh.new = function(vertices, vertex_count, vertex_stride, indices, index_count, index_stride, shader)
    return utils.new(M.SceneMesh, {
        vertices = vertices,
        vertex_count = vertex_count,
        vertex_stride = vertex_stride,
        indices = indices,
        index_count = index_count,
        index_stride = index_stride,
        shader = shader or "MINIMAL",
    })
end

return M
