local utils = require "limgui.utils"
local maf = require "mafex"

local M = {}

---@class SceneTexture
---@field name string
M.SceneTexture = {}

---comment
---@param name string
---@param image_slice Slice
---@return SceneTexture
M.SceneTexture.new = function(name, image_slice)
    return utils.new(M.SceneTexture, {
        name = name,
    })
end

---@class SceneMaterial
---@field name string
---@field shader string|table
---@field base_color ffi.cdata* RGBA
---@field base_texture SceneTexture
M.SceneMaterial = {}

---comment
---@param name string
---@param shader string
---@return SceneMaterial
M.SceneMaterial.new = function(name, shader)
    return utils.new(M.SceneMaterial, {
        name = name,
        shader = shader,
        base_color = maf.vec4(1, 1, 1, 1),
    })
end

return M
