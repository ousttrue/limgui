local imgui_ffi = require "imgui_ffi.mod"
local const = imgui_ffi.enums
local imgui = imgui_ffi.libs.imgui
local utils = require "limgui.utils"

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

-- accessor require
-- has_child(node) -> bool
-- column(node, i) -> value
-- equal(node, node) -> bool
-- each(parent, function(node))

---@class GUITable
---@field flags number
---@field columns Column[]
---@field root any
---@field selected any
M.GuiTable = {
    draw_node = function(self, node, accessor)
        imgui.TableNextRow()
        local has_child = accessor.has_child(node)
        local open = false
        for i, col in ipairs(self.columns) do
            imgui.TableNextColumn()
            local value = accessor.column(node, i)
            if i == 1 then
                local flag = 0 -- const.ImGuiTreeNodeFlags_.SpanFullWidth
                if not has_child then
                    flag = bit.bor(
                        flag,
                        const.ImGuiTreeNodeFlags_.Leaf,
                        const.ImGuiTreeNodeFlags_.Bullet,
                        const.ImGuiTreeNodeFlags_.NoTreePushOnOpen
                    )
                end
                open = imgui.TreeNodeEx(value, flag)
                imgui.SetItemAllowOverlap()
            elseif i == 2 then
                if
                    imgui.Selectable(
                        value,
                        accessor.equal(self.selected, node),
                        const.ImGuiSelectableFlags_.SpanAllColumns
                    )
                then
                    self.selected = node
                end
                if imgui.IsItemClicked() then
                    self.selected = node
                end
            else
                if value then
                    imgui.TextUnformatted(value)
                else
                    imgui.TextDisabled "--"
                end
            end
        end
        if open and has_child then
            accessor.each(node, function(child)
                self:draw_node(child, accessor)
            end)
            imgui.TreePop()
        end
    end,

    draw = function(self, root, accessor)
        if not self.TEXT_BASE_WIDTH then
            -- self.TEXT_BASE_WIDTH = imgui.CalcTextSize("A").x
            self.TEXT_BASE_WIDTH = 10
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
