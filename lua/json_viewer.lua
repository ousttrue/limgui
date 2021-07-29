local ffi = require("ffi")
local bit = require("bit")
local imgui_ffi = require("imgui_ffi.mod")
local imgui = imgui_ffi.libs.imgui
local C = imgui_ffi.enums
local json = require("json")

---@class GUIJsonViewer
local gui = {
    clear_color = ffi.new("float[4]", 0.45, 0.55, 0.6, 1),
    use_work_area = ffi.new("bool[1]", true),
    flags = bit.bor(
        C.ImGuiWindowFlags_.ImGuiWindowFlags_NoDecoration,
        C.ImGuiWindowFlags_.ImGuiWindowFlags_NoMove,
        C.ImGuiWindowFlags_.ImGuiWindowFlags_NoResize,
        C.ImGuiWindowFlags_.ImGuiWindowFlags_NoSavedSettings
    ),
    table_flags = bit.bor(
        C.ImGuiTableFlags_.ImGuiTableFlags_BordersV,
        C.ImGuiTableFlags_.ImGuiTableFlags_BordersOuterH,
        C.ImGuiTableFlags_.ImGuiTableFlags_Resizable,
        C.ImGuiTableFlags_.ImGuiTableFlags_RowBg,
        C.ImGuiTableFlags_.ImGuiTableFlags_NoBordersInBody
    ),

    ---@param self GUIJsonViewer
    draw_node = function(self, k, v)
        imgui.TableNextRow()
        imgui.TableNextColumn()

        -- print(k, v)
        local t = type(v)
        if t == "table" then
            -- name
            local open = imgui.TreeNodeEx(k, C.ImGuiTreeNodeFlags_.ImGuiTreeNodeFlags_SpanFullWidth)

            imgui.TableNextColumn()
            if #v > 0 then
                -- type
                imgui.TextUnformatted("[]")
                if open then
                    for i, child in ipairs(v) do
                        self:draw_node(tostring(i), child)
                    end
                end
            else
                imgui.TextUnformatted("{}")
                if open then
                    for k, child in pairs(v) do
                        self:draw_node(k, child)
                    end
                end
            end

            if open then
                imgui.TreePop()
            end
        else
            imgui.TreeNodeEx(
                k,
                bit.bor(
                    C.ImGuiTreeNodeFlags_.ImGuiTreeNodeFlags_Leaf,
                    C.ImGuiTreeNodeFlags_.ImGuiTreeNodeFlags_Bullet,
                    C.ImGuiTreeNodeFlags_.ImGuiTreeNodeFlags_NoTreePushOnOpen,
                    C.ImGuiTreeNodeFlags_.ImGuiTreeNodeFlags_SpanFullWidth
                )
            )
            imgui.TableNextColumn()
            imgui.TextUnformatted(t)
            imgui.TableNextColumn()
            imgui.TextUnformatted(string.format("%q", v))
        end
    end,

    draw_table = function(self)
        if not self.TEXT_BASE_WIDTH then
            self.TEXT_BASE_WIDTH = imgui.CalcTextSize("A").x
        end

        if imgui.BeginTable("3ways", 3, self.flags) then
            -- The first column will use the default _WidthStretch when ScrollX is Off and _WidthFixed when ScrollX is On
            imgui.TableSetupColumn("Name", C.ImGuiTableColumnFlags_.ImGuiTableColumnFlags_NoHide)
            imgui.TableSetupColumn(
                "Type",
                C.ImGuiTableColumnFlags_.ImGuiTableColumnFlags_WidthFixed,
                self.TEXT_BASE_WIDTH * 18.0
            )
            imgui.TableSetupColumn(
                "Value",
                C.ImGuiTableColumnFlags_.ImGuiTableColumnFlags_WidthFixed,
                self.TEXT_BASE_WIDTH * 18.0
            )
            imgui.TableHeadersRow()

            self:draw_node("__root__", self.json)

            imgui.EndTable()
        end
    end,

    ---@param self GUIJsonViewer
    update = function(self)
        -- full screen node
        -- We demonstrate using the full viewport area or the work area (without menu-bars, task-bars etc.)
        -- Based on your use case you may want one of the other.
        local viewport = imgui.GetMainViewport()
        imgui.SetNextWindowPos(self.use_work_area[0] and viewport.WorkPos or viewport.Pos)
        imgui.SetNextWindowSize(self.use_work_area[0] and viewport.WorkSize or viewport.Size)

        if imgui.Begin("Example: Fullscreen window", nil, self.flags) then
            -- table
            self:draw_table()
        end

        imgui.End()
    end,
}

local arg = os.getenv("JSON_PATH")
local r = io.open(arg, "rb")
local src = r:read("*a")
r:close()
gui.json = json.decode(src)

local app = require("app")
local TITLE = "JsonViewer"
if not app:initialize(1200, 900, TITLE) then
    os.exit(1)
end

-- Main loop
while app:new_frame() do
    gui:update()
    app:render(gui.clear_color)
end
