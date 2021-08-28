local utils = require "limgui.utils"
local ffi = require "ffi"

local M = {}

---@class VertexLayout
M.VertexLayout = {}
M.VertexLayout.new = function(layout)
    return utils.new(M.VertexLayout, layout)
end

---@class Scene
---@field vertices any
---@field vertex_count integer
---@field indices any
---@field index_count integer
---@field shader_name string
---@field layout VertexLayout[]
M.Scene = {}
M.Scene.triangle = function()
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

    return utils.new(M.Scene, {
        vertices = vertices,
        vertex_count = 3,
        shader_name = "MINIMAL",
        layout = M.VertexLayout.new {},
    })
end

-- https://www.glfw.org/docs/latest/quick.html
ffi.cdef [[
struct Vertex2DRGB
{
    float x, y;
    float r, g, b;
};
]]
M.Scene.xyrgb_triangle = function()
    local vertices = ffi.new(
        "struct Vertex2DRGB[3]",
        { -0.6, -0.4, 1., 0., 0. },
        { 0.6, -0.4, 0., 1., 0. },
        { 0., 0.6, 0., 0., 1. }
    )

    assert(vertices[2].b == 1.0)

    return utils.new(M.Scene, {
        vertices = vertices,
        vertex_count = 3,
        shader_name = "MVP",
    })
end

--- create vertex buffer
--- TODO: layout
---@param vertices ffi.cdata* Hoge[]
---@param indices ffi.cdata* uint8_t[]
---@return table<string, any>
M.Scene.create = function(vertices, vertex_count, indices, index_count)
    return utils.new(M.Scene, {
        vertices = vertices,
        vertex_count = vertex_count,
        indices = indices,
        index_count = index_count,
        shader_name = "MINIMAL",
    })
end

return M
