local ffi = require("ffi")
local imgui_ffi = require("imgui_ffi.mod")
local imgui = imgui_ffi.libs.imgui
local const = imgui_ffi.enums
local W = require("limgui")
local uv = require("luv")
local utils = require("limgui.utils")

--
-- libclang task
--
local function on_thread(data)
    local CommandLine = require("clangffi.commandline")
    local Parser = require("clangffi.parser")
    local mp = require("libs.luajit-msgpack-pure")

    local offset, args = mp.unpack(data)
    local cmd = CommandLine.parse(args)
    local parser = Parser.new()
    parser:parse(cmd.EXPORTS, cmd.CFLAGS)
    print(parser.node_count)

    print("remove_duplicated...")
    local count = parser.root:remove_duplicated()
    print(count)
    return mp.pack(parser.root)
end

local mp = require("libs.luajit-msgpack-pure")
local ROOT
local function on_end(dst, src)
    local offset, root = mp.unpack(dst)
    ROOT = root
end

local ON_THREAD = true
if ON_THREAD then
    local ctx = uv.new_work(
        on_thread, --work,in threadpool
        on_end --after work, in loop thread
    )
    uv.queue_work(ctx, mp.pack({ ... }))
else
    --- sync
    local result = on_thread(mp.pack({ ... }))
    on_end(result)
end

-- Main loop
local app = require("app")
local TITLE = "ClangViewer"
if not app:initialize(1200, 900, TITLE) then
    os.exit(1)
end

---@class CursorKind
---@field visible boolean
---@field count number
local CursorKind = {
    ---@param self CursorKind
    increment = function(self)
        self.count = self.count + 1
    end,

    update = function(self)
        imgui.Checkbox(string.format("%s(%d)", self.name, self.count), self.visible)
    end,
}
---@param name string
CursorKind.new = function(name)
    local instance = {
        name = name,
        visible = ffi.new("bool[1]", true),
        count = 1,
    }
    CursorKind.__index = CursorKind
    setmetatable(instance, CursorKind)
    return instance
end

local clang_ffi = require("clang.mod")
local reverse_map = {}
for k, v in pairs(clang_ffi.enums.CXCursorKind) do
    reverse_map[v] = k
end

local KIND = "Kind"
local CURSOR = "Cursor"
local SELECTED = "Selected"

---@class ClangViewerGUI
---@field kind_list CursorKind[]
---@field kind_map Table<number, CursorKind>
local gui = {
    clear_color = ffi.new("float[4]", 0.45, 0.55, 0.6, 1),

    cache_map = {},

    dockspace = W.GuiDockSpace.new(
        "dockspace",
        -- dock node tree
        W.DockNode.new("Root", const.ImGuiDir_.Left, 0.5, {
            W.DockNode.new("Left", const.ImGuiDir_.Up, 0.5, {
                W.DockNode.new(KIND),
                W.DockNode.new(CURSOR),
            }),
            W.DockNode.new(SELECTED),
        })
    ),

    table = W.GuiTable.new("cursor_table", {
        W.Column.new("spelling", const.ImGuiTableColumnFlags_.NoHide),
        W.Column.new("cursor", const.ImGuiTableColumnFlags_.WidthFixed, 8.0),
        W.Column.new("header", const.ImGuiTableColumnFlags_.WidthFixed, 12.0),
        W.Column.new("line", const.ImGuiTableColumnFlags_.WidthFixed, 4.0),
    }),

    ---@param self ClangViewerGUI
    ---@param node Node
    build_map = function(self, node)
        local cursor_type_counter = self.kind_map[node.cursor_kind]
        if cursor_type_counter then
            cursor_type_counter:increment()
        else
            local kind = CursorKind.new(reverse_map[node.cursor_kind])
            table.insert(self.kind_list, kind)
            self.kind_map[node.cursor_kind] = kind
        end

        if node.children then
            for i, child in ipairs(node.children) do
                self:build_map(child)
            end
        end
    end,

    ---@param self ClangViewerGUI
    ---@param root any
    ---@param accessor any
    update = function(self, root, accessor)
        self.dockspace:draw()

        -- draw node tree
        imgui.Begin(KIND)
        if self.kind_list then
            for i, kind in ipairs(self.kind_list) do
                kind:update()
            end
        end
        imgui.End()

        imgui.Begin(CURSOR)
        if self.kind_map then
            self.table:draw(root, accessor)
        end
        imgui.End()

        if root and not self.kind_map then
            -- create map
            self.kind_map = {}
            self.kind_list = {}
            self:build_map(root)
        end

        imgui.Begin(SELECTED)
        if self.table.selected and self.table.selected.location then
            local path = self.table.selected.location.path
            imgui.TextUnformatted(path)
            local text = self.cache_map[path]
            if not text then
                text = utils.read_file(path)
                self.cache_map[path] = text
            end
            imgui.TextUnformatted(text)
        end
        imgui.End()
    end,
}

local function table_filter(t, filter)
    local l = {}
    for i, v in ipairs(t) do
        if filter(i, v) then
            table.insert(l, v)
        end
    end
    return l
end

local accessor = {
    has_child = function(node)
        if node.children then
            for i, v in ipairs(node.children) do
                if gui.kind_map[v.cursor_kind].visible[0] then
                    return true
                end
            end
        end
    end,
    each = function(node, callback)
        if node.children then
            for i, v in ipairs(node.children) do
                if gui.kind_map[v.cursor_kind].visible[0] then
                    callback(i, v)
                end
            end
        end
    end,
    column = function(node, i)
        if i == 1 then
            return string.format("%s##%s", node.spelling, node.hash)
        elseif i == 2 then
            return reverse_map[node.cursor_kind]
        elseif i == 3 then
            if node.location then
                local m = node.location.path:match("[^\\]+$")
                if m then
                    return m
                end
                return node.location.path
            end
        elseif i == 4 then
            if node.location then
                return tostring(node.location.line)
            end
        end
    end,
    equal = function(a, b)
        return a == b
    end,
}

-- local profiler = require("libs.profiler")
-- profiler.start()

local idle = uv.new_idle()
idle:start(function()
    if not app:new_frame() then
        idle:stop()
    end
    gui:update(ROOT, accessor)
    local w, h = app.window:getFramebufferSize()
    require("limgui.renderer").clear(w, h, gui.clear_color)
    app:render()
end)

uv.run("default")

-- -- Code block and/or called functions to profile --
-- profiler.stop()
-- profiler.report("profiler.log")
