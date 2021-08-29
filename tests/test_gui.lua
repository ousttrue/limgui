local luaunit = require "luaunit"
package.path = package.path .. ";lua/?.lua"
local imgui_ffi = require "imgui_ffi.mod"
local imgui = imgui_ffi.libs.imgui
local C = imgui_ffi.enums
local W = require "limgui"
local bit = require "bit"

function TestTable()
    local t = W.GuiTable.new("json_tree", {
        W.Column.new("Name", bit.bor(C.ImGuiTableColumnFlags_.NoHide, C.ImGuiTableColumnFlags_.WidthFixed), 24.0),
        W.Column.new("Type", C.ImGuiTableColumnFlags_.WidthFixed, 18.0),
        W.Column.new("Value", C.ImGuiTableColumnFlags_.WidthStretch),
    })
    local accessor = {
        has_child = function(node)
            return false
        end,
        each = function(node, callback) end,
        column = function(kv, i)
            return "COL"
        end,
        equal = function(a, b)
            return a == b
        end,
    }   
    imgui.CreateContext(nil)
    -- TODO
    -- imgui.NewFrame()
    -- t:draw({}, accessor)
    luaunit.assertIsTrue(true)
end
TestTable()

os.exit(luaunit.LuaUnit.run())
