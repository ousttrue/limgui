local ffi = require "ffi"
local bit = require "bit"
local imgui_ffi = require "imgui_ffi.mod"
local imgui = imgui_ffi.libs.imgui
local C = imgui_ffi.enums
local W = require "limgui"
local engine = require "engine.mod"
local scene = require "scene.init"
local maf = require "mafex"

local app = require "app"
local TITLE = "GltfViewer"
if not app:initialize(1200, 900, TITLE) then
    os.exit(1)
end
-- load OpenGL
require("gl_ffi.mod").load(require "gl_ffi.glfw")
local renderer = engine.Renderer.new()

-- GUI
local JSON = "JSON"
local VIEW = "View"
local SCENE = "Scene"
local gui = {

    clear_color = ffi.new("float[4]", 0.45, 0.55, 0.6, 1),
    use_work_area = ffi.new("bool[1]", true),
    light_yaw = ffi.new("float[1]", 30),
    light_pitch = ffi.new("float[1]", 60),

    dockspace = W.GuiDockSpace.new(
        "dockspace",
        -- dock node tree
        W.DockNode.new("Root", C.ImGuiDir_.Left, 0.3, {
            W.DockNode.new(JSON),
            W.DockNode.new("RIGHT", C.ImGuiDir_.Right, 0.4, {
                W.DockNode.new(SCENE),
                W.DockNode.new(VIEW),
            }),
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

        imgui.Begin(SCENE)
        imgui.SliderFloat("light_yaw", self.light_yaw, -180, 180)
        imgui.SliderFloat("light_pitch", self.light_pitch, -90, 90)
        imgui.End()
    end,
}

-- tree accessor
local accessor = {
    ---comment
    ---@param node table
    ---@return boolean
    has_child = function(node)
        return type(node[2]) == "table"
    end,
    ---comment
    ---@param node table
    ---@param callback fun(node: table):nil
    each = function(node, callback)
        -- local k = kv[1]
        local v = node[2]
        local t = type(v)
        if t == "table" then
            if #v > 0 then
                -- array
                for i, x in ipairs(v) do
                    callback { tostring(i - 1), x }
                end
            else
                -- dict
                local keys = {}
                for k, v in pairs(v) do
                    table.insert(keys, k)
                end
                table.sort(keys)
                for i, k in ipairs(keys) do
                    callback { k, v[k] }
                end
            end
        end
    end,
    ---comment
    ---@param node table
    ---@param i any Name, Type, Value
    ---@return string
    column = function(node, i)
        if i == 1 then
            return node[1]
        elseif i == 2 then
            local t = type(node[2])
            if t == "table" then
                if #node[2] > 0 then
                    return "array"
                else
                    return "object"
                end
            end
            return t
        elseif i == 3 then
            local t = type(node[2])
            if t == "table" then
                if #node[2] > 0 then
                    return "[]"
                else
                    return "{}"
                end
            end
            return tostring(node[2])
        end
    end,
    ---comment
    ---@param a table
    ---@param b table
    ---@return boolean
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

--- Load JSON
local args = { ... }
local loader = scene.GltfLoader.from_path(args[1])

--- camera
local w, h = app.window:getSize()
local camera = engine.OrbitCamera.new(w, h)

-- bind event
app.window:setCursorPosCallback(function(window, x, y)
    camera:mouse_move(x, y)
end)
app.window:setMouseButtonCallback(function(window, button, is_down)
    camera:mouse_button(button, is_down ~= 0)
end)
app.window:setScrollCallback(function(window, x, y)
    camera:mouse_wheel(y)
end)
app.window:setSizeCallback(function(window, w, h)
    camera:resize(w, h)
end)

local world = scene.World.new()
local light_direction = maf.vec3(0, 0, -1)

-- Main loop
while app:new_frame() do
    -- update
    gui:update({ "__root__", loader.gltf }, accessor)
    local width, height = app.window:getFramebufferSize()
    world.Projection = camera.projection
    world.View = camera.view
    world.LightDirection = (maf.mat3.rotation_y(gui.light_yaw[0]) * maf.mat3.rotation_x(gui.light_pitch[0])):apply(
        light_direction
    )

    -- render
    renderer:clear(width, height, gui.clear_color)
    renderer:render_recursive(loader.root, world)
    app:render()
end
