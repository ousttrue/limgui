local utils = require("limgui.utils")
local ffi = require("ffi")

local M = {}

---@class Scene
---@field vertices any
---@field vertex_count number
---@field shader_name string
M.Scene = {}
M.Scene.triangle = function()
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

    return utils.new(M.Scene, {
        vertices = vertices,
        vertex_count = 3,
        shader_name = "MINIMAL",
    })
end

return M
