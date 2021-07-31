--
-- Lua ImGui
--
local utils = require("limgui.utils")
local M = {}

utils.merge(require("limgui.gui_table"), M)
utils.merge(require("limgui.gui_dockspace"), M)

return M
