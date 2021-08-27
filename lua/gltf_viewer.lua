local ffi = require("ffi")
local bit = require("bit")
local imgui_ffi = require("imgui_ffi.mod")
local imgui = imgui_ffi.libs.imgui
local C = imgui_ffi.enums
local json = require("libs.json")
local W = require("limgui")
local utils = require("limgui.utils")
local engine = require("engine.mod")

--- Load JSON
local args = { ... }
local r = io.open(args[1], "rb")
local src = r:read("*a")
r:close()
local json = json.decode(src)

local app = require("app")
local TITLE = "GltfViewer"
if not app:initialize(1200, 900, TITLE) then
    os.exit(1)
end
-- load OpenGL
require("libs.gl_ffi.mod").load(require("libs.gl_ffi.glfw"))
local renderer = engine.Renderer.new()
local triangle = engine.Scene:triangle()

-- GUI
local JSON = "JSON"
local VIEW = "View"
local gui = {

    clear_color = ffi.new("float[4]", 0.45, 0.55, 0.6, 1),
    use_work_area = ffi.new("bool[1]", true),

    dockspace = W.GuiDockSpace.new(
        "dockspace",
        -- dock node tree
        W.DockNode.new("Root", C.ImGuiDir_.Left, 0.5, {
            W.DockNode.new(JSON),
            W.DockNode.new(VIEW),
        })
    ):passthru(true),

    table = W.GuiTable.new("json_tree", {
        W.Column.new("Name", bit.bor(C.ImGuiTableColumnFlags_.NoHide, C.ImGuiTableColumnFlags_.WidthFixed), 24.0),
        W.Column.new("Type", C.ImGuiTableColumnFlags_.WidthFixed, 18.0),
        W.Column.new("Value", C.ImGuiTableColumnFlags_.WidthStretch),
    }),

    update = function(self, root, accessor)
        self.dockspace:draw()

        imgui.Begin(JSON)
        self.table:draw(root, accessor)
        imgui.End()
    end,
}

-- tree accessor
local accessor = {
    has_child = function(kv)
        return type(kv[2]) == "table"
    end,
    each = function(kv, callback)
        -- local k = kv[1]
        local v = kv[2]
        local t = type(v)
        if t == "table" then
            if #v > 0 then
                for i, x in ipairs(v) do
                    callback({ tostring(i), x })
                end
            else
                local keys = {}
                for k, v in pairs(v) do
                    table.insert(keys, k)
                end
                table.sort(keys)
                for i, k in ipairs(keys) do
                    callback({ k, v[k] })
                end
            end
        end
    end,
    column = function(kv, i)
        if i == 1 then
            return kv[1]
        elseif i == 2 then
            local t = type(kv[2])
            if t == "table" then
                if #kv[2] > 0 then
                    return "array"
                else
                    return "object"
                end
            end
            return t
        elseif i == 3 then
            local t = type(kv[2])
            if t == "table" then
                if #kv[2] > 0 then
                    return "[]"
                else
                    return "{}"
                end
            end
            return tostring(kv[2])
        end
    end,
    equal = function(a, b)
        if a and b then
            return (a and a[2]) == (b and b[2])
        elseif not a and not b then
            return true
        else
            return false
        end
    end,
}
-- Main loop
while app:new_frame() do
    gui:update({ "__root__", json }, accessor)
    local width, height = app.window:getFramebufferSize()
    renderer:clear(width, height, gui.clear_color)
    renderer:render(triangle)
    app:render()
end
