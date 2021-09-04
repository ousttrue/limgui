local utils = require "limgui.utils"

local M = {}

---@class SceneWorld
---@field Projection mat4
---@field View mat4
---@field LightDirection vec3
M.SceneWorld = {}

M.SceneWorld.new = function()
    return utils.new(M.SceneWorld, {})
end

return M
