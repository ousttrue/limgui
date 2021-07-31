local ffi = require("ffi")
local imgui_ffi = require("imgui_ffi.mod")
local imgui = imgui_ffi.libs.imgui
local const = imgui_ffi.enums
local W = require("imgui_widgets.init")
local uv = require("luv")

--
-- libclang task
--
local mp = require("luajit-msgpack-pure")
local function on_thread(data)
    local CommandLine = require("clangffi.commandline")
    local Parser = require("clangffi.parser")
    local mp = require("luajit-msgpack-pure")

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

local ROOT
local function on_end(dst, src)
    local offset, root = mp.unpack(dst)
    ROOT = root
end

if true then
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

--
-- gui
--
local gui = {
    clear_color = ffi.new("float[4]", 0.45, 0.55, 0.6, 1),

    dockspace = W.GuiDockSpace.new("dockspace", {
        W.DockNode.new("Left", const.ImGuiDir_.Left, 0.5),
        W.DockNode.new("Down", const.ImGuiDir_.Down, 0.25),
    }),

    table = W.GuiTable.new("cursor_table", {
        W.Column.new("spelling", const.ImGuiTableColumnFlags_.NoHide),
        W.Column.new("cursor", const.ImGuiTableColumnFlags_.WidthFixed, 8.0),
        W.Column.new("header", const.ImGuiTableColumnFlags_.WidthFixed, 12.0),
        W.Column.new("line", const.ImGuiTableColumnFlags_.WidthFixed, 4.0),
    }),

    update = function(self, root, accessor)
        self.dockspace:draw()

        -- draw node tree
        imgui.Begin(self.dockspace.nodes[1].name)
        if root then
            self.table:draw(root, accessor)
        end
        imgui.End()

        imgui.Begin(self.dockspace.nodes[2].name)
        imgui.End()
    end,
}

local clang_ffi = require("clang.mod")
local reverse_map = {}
for k, v in pairs(clang_ffi.enums.CXCursorKind) do
    reverse_map[v] = k
end

local idle = uv.new_idle()
idle:start(function()
    if not app:new_frame() then
        idle:stop()
    end
    gui:update(ROOT, {
        children = function(node)
            return node.children
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
    })
    app:render(gui.clear_color)
end)

uv.run("default")
