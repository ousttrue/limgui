local utils = require "limgui.utils"

local M = {}

---@class VertexLayout
M.VertexLayout = {}
M.VertexLayout.new = function(layout)
    return utils.new(M.VertexLayout, layout)
end

return M
