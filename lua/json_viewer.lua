local ffi = require("ffi")
local bit = require("bit")
local imgui_ffi = require("imgui_ffi.mod")
local imgui = imgui_ffi.libs.imgui
local C = imgui_ffi.enums
local json = require("libs.json")
local W = require("limgui")
local utils = require("limgui.utils")

--- Load JSON
local arg = os.getenv("JSON_PATH")
local r = io.open(arg, "rb")
local src = r:read("*a")
r:close()
local json = json.decode(src)

local app = require("app")
local TITLE = "JsonViewer"
if not app:initialize(1200, 900, TITLE) then
    os.exit(1)
end

local gui = {

    clear_color = ffi.new("float[4]", 0.45, 0.55, 0.6, 1),
    use_work_area = ffi.new("bool[1]", true),

    flags = bit.bor(
        C.ImGuiWindowFlags_.NoDecoration,
        C.ImGuiWindowFlags_.NoMove,
        C.ImGuiWindowFlags_.NoResize,
        C.ImGuiWindowFlags_.NoSavedSettings
    ),

    table = W.GuiTable.new("json_tree", {
        W.Column.new("Name", bit.bor(C.ImGuiTableColumnFlags_.NoHide, C.ImGuiTableColumnFlags_.WidthFixed), 24.0),
        W.Column.new("Type", C.ImGuiTableColumnFlags_.WidthFixed, 18.0),
        W.Column.new("Value", C.ImGuiTableColumnFlags_.WidthStretch),
    }),

    update = function(self, root, accessor)
        -- full screen node
        -- We demonstrate using the full viewport area or the work area (without menu-bars, task-bars etc.)
        -- Based on your use case you may want one of the other.
        local viewport = imgui.GetMainViewport()
        imgui.SetNextWindowPos(self.use_work_area[0] and viewport.WorkPos or viewport.Pos)
        imgui.SetNextWindowSize(self.use_work_area[0] and viewport.WorkSize or viewport.Size)

        if imgui.Begin("Example: Fullscreen window", nil, self.flags) then
            self.table:draw(root, accessor)
        end
        imgui.End()
    end,
}

-- Main loop
while app:new_frame() do
    gui:update({ "__root__", json }, {
        children = function(kv)
            -- local k = kv[1]
            local v = kv[2]
            local t = type(v)
            if t == "table" then
                if #v > 0 then
                    return utils.imap(v, function(i, x)
                        return { tostring(i), x }
                    end)
                else
                    local result = utils.map(v, function(k, x)
                        return { k, x }
                    end)
                    table.sort(result, function(a, b)
                        return a[1] < b[1]
                    end)
                    return result
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
    })
    app:render(gui.clear_color)
end
