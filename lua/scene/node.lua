local utils = require "limgui.utils"
local M = {}

---@class SceneNode
---@field name string
---@field mesh SceneMesh
---@field t vec3
---@field r quat
---@field s vec3
---@field children SceneNode[]
M.SceneNode = {}

---comment
---@param name string
---@return SceneNode
M.SceneNode.new = function(name)
    return utils.new(M.SceneNode, {
        name = name,
        children = {},
    })
end

return M
