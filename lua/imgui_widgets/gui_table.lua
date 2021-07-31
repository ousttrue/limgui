local imgui_ffi = require("imgui_ffi.mod")
local const = imgui_ffi.enums
local imgui = imgui_ffi.libs.imgui
local utils = require("imgui_widgets.utils")

local M = {}

---@class Column
---@field label string
---@field name string
---@field flag number
---@field width number
M.Column = {
    draw = function(self, f)
        imgui.TableSetupColumn(self.label, self.flag, self.width and self.width * f or nil)
    end,
}
M.Column.new = function(label, flag, width)
    return utils.new(M.Column, {
        label = label,
        flag = flag,
        width = width,
    })
end

---@class GUITable
---@field flags number
---@field columns Column[]
---@field root any
M.GuiTable = {
    draw_node = function(self, node, accessor)
        imgui.TableNextRow()
        local children = accessor.children(node)
        local open = false
        for i, col in ipairs(self.columns) do
            imgui.TableNextColumn()
            if i == 1 then
                local flag = const.ImGuiTreeNodeFlags_.SpanFullWidth
                if not children then
                    flag = bit.bor(
                        flag,
                        const.ImGuiTreeNodeFlags_.Leaf,
                        const.ImGuiTreeNodeFlags_.Bullet,
                        const.ImGuiTreeNodeFlags_.NoTreePushOnOpen
                    )
                end
                open = imgui.TreeNodeEx(accessor.column(node, 1), flag)
            else
                local value = accessor.column(node, i)
                if value then
                    imgui.TextUnformatted(value)
                else
                    imgui.TextDisabled("--")
                end
            end
        end
        if open and children then
            for j, child in ipairs(children) do
                self:draw_node(child, accessor)
            end
            imgui.TreePop()
        end
    end,

    draw = function(self, root, accessor)
        if not self.TEXT_BASE_WIDTH then
            self.TEXT_BASE_WIDTH = imgui.CalcTextSize("A").x
        end

        if imgui.BeginTable(self.name, #self.columns, self.flags) then
            -- header
            for i, col in ipairs(self.columns) do
                col:draw(self.TEXT_BASE_WIDTH)
            end
            imgui.TableHeadersRow()

            -- body
            imgui.SetNextItemOpen(true, const.ImGuiCond_.Once)
            self:draw_node(root, accessor)

            imgui.EndTable()
        end
    end,
}
M.GuiTable.new = function(name, columns)
    return utils.new(M.GuiTable, {
        name = name,
        flags = bit.bor(
            const.ImGuiTableFlags_.BordersV,
            const.ImGuiTableFlags_.BordersOuterH,
            const.ImGuiTableFlags_.Resizable,
            const.ImGuiTableFlags_.RowBg,
            const.ImGuiTableFlags_.NoBordersInBody
        ),
        columns = columns,
    })
end

return M
