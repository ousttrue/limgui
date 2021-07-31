local utils = require("imgui_widgets.utils")
local M = {}

utils.merge(require("imgui_widgets.gui_table"), M)
utils.merge(require("imgui_widgets.gui_dockspace"), M)

return M
