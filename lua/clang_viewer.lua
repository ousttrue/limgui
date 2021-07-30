local ffi = require("ffi")
local bit = require("bit")
local imgui_ffi = require("imgui_ffi.mod")
local imgui = imgui_ffi.libs.imgui
local const = imgui_ffi.enums

---@param klass Table<string, any> metatable
---@param instance Table<string, any> instance
local function new(klass, instance)
    klass.__index = klass
    setmetatable(instance, klass)
    return instance
end

---@class Column
---@field label string
---@field name string
---@field flag number
---@field width number
local Column = {
    draw = function(self, f)
        imgui.TableSetupColumn(self.label, self.flag, self.width and self.width * f or nil)
    end,
}
Column.new = function(label, flag, width)
    return new(Column, {
        label = label,
        flag = flag,
        width = width,
    })
end

---@class GUITable
---@field flags number
---@field columns Column[]
---@field root any
local GuiTable = {
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
GuiTable.new = function(name)
    return new(GuiTable, {
        name = name,
        flags = bit.bor(
            const.ImGuiTableFlags_.BordersV,
            const.ImGuiTableFlags_.BordersOuterH,
            const.ImGuiTableFlags_.Resizable,
            const.ImGuiTableFlags_.RowBg,
            const.ImGuiTableFlags_.NoBordersInBody
        ),
    })
end

--- https://gist.github.com/PossiblyAShrub/0aea9511b84c34e191eaa90dd7225969
---@class GuiClangViewer
---@field clear_color any
---@field table any
local GuiClangViewer = {
    dockspace = function(self)
        -- We are using the ImGuiWindowFlags_NoDocking flag to make the parent window not dockable into,
        -- because it would be confusing to have two docking targets within each others.
        local window_flags = bit.bor(const.ImGuiWindowFlags_.MenuBar, const.ImGuiWindowFlags_.NoDocking)

        local viewport = imgui.GetMainViewport()
        imgui.SetNextWindowPos(viewport.Pos)
        imgui.SetNextWindowSize(viewport.Size)
        imgui.SetNextWindowViewport(viewport.ID)
        imgui.PushStyleVar(const.ImGuiStyleVar_.WindowRounding, 0.0)
        imgui.PushStyleVar(const.ImGuiStyleVar_.WindowBorderSize, 0.0)
        window_flags = bit.bor(
            window_flags,
            const.ImGuiWindowFlags_.NoTitleBar,
            const.ImGuiWindowFlags_.NoCollapse,
            const.ImGuiWindowFlags_.NoResize,
            const.ImGuiWindowFlags_.NoMove
        )
        window_flags = bit.bor(
            window_flags,
            const.ImGuiWindowFlags_.NoBringToFrontOnFocus,
            const.ImGuiWindowFlags_.NoNavFocus
        )

        -- When using ImGuiDockNodeFlags_PassthruCentralNode, DockSpace() will render our background and handle the pass-thru hole, so we ask Begin() to not render a background.
        if bit.band(self.dockspace_flags, const.ImGuiDockNodeFlags_.PassthruCentralNode) ~= 0 then
            window_flags = bit.bor(window_flags, const.ImGuiWindowFlags_.NoBackground)
        end

        -- Important: note that we proceed even if Begin() returns false (aka window is collapsed).
        -- This is because we want to keep our DockSpace() active. If a DockSpace() is inactive,
        -- all active windows docked into it will lose their parent and become undocked.
        -- We cannot preserve the docking relationship between an active window and an inactive docking, otherwise
        -- any change of dockspace/settings would lead to windows being stuck in limbo and never being visible.
        imgui.PushStyleVar__1(const.ImGuiStyleVar_.WindowPadding, ffi.new("struct ImVec2"))
        imgui.Begin("DockSpace", nil, window_flags)
        imgui.PopStyleVar()
        imgui.PopStyleVar(2)

        -- DockSpace
        local io = imgui.GetIO()
        io.ConfigFlags = bit.bor(io.ConfigFlags, const.ImGuiConfigFlags_.DockingEnable)
        if bit.band(io.ConfigFlags, const.ImGuiConfigFlags_.DockingEnable) ~= 0 then
            self.dockspace_id[0] = imgui.GetID("MyDockSpace")
            imgui.DockSpace(self.dockspace_id[0], ffi.new("struct ImVec2"), self.dockspace_flags)

            if imgui.BeginMenuBar() then
                if imgui.BeginMenu("File") then
                    if imgui.MenuItem("Open", "Ctrl+O") then
                        print("open file")
                    end
                    imgui.Separator()
                    imgui.EndMenu()
                end
                imgui.EndMenuBar()
            end

            if self.first_time then
                -- layout dock nodes
                self.first_time = false

                imgui.DockBuilderRemoveNode(self.dockspace_id[0]) -- clear any previous layout
                imgui.DockBuilderAddNode(
                    self.dockspace_id[0],
                    bit.bor(self.dockspace_flags, const.ImGuiDockNodeFlagsPrivate_.ImGuiDockNodeFlags_DockSpace)
                )
                imgui.DockBuilderSetNodeSize(self.dockspace_id[0], viewport.Size)

                -- split the dockspace into 2 nodes -- DockBuilderSplitNode takes in the following args in the following order
                --   window ID to split, direction, fraction (between 0 and 1), the final two setting let's us choose which id we want (which ever one we DON'T set as NULL, will be returned by the function)
                --                                                              out_id_at_dir is the id of the node in the direction we specified earlier, out_id_at_opposite_dir is in the opposite direction
                local dock_id_left = imgui.DockBuilderSplitNode(
                    self.dockspace_id[0],
                    const.ImGuiDir_.Left,
                    0.5,
                    nil,
                    self.dockspace_id
                )
                local dock_id_down = imgui.DockBuilderSplitNode(
                    self.dockspace_id[0],
                    const.ImGuiDir_.Down,
                    0.25,
                    nil,
                    self.dockspace_id
                )

                -- we now dock our windows into the docking node we made above
                imgui.DockBuilderDockWindow("Down", dock_id_down)
                imgui.DockBuilderDockWindow("Cursor", dock_id_left)
                imgui.DockBuilderFinish(self.dockspace_id[0])
            end
        end

        imgui.End()
    end,

    ---@param self GuiClangViewer
    update = function(self, root, accessor)
        self:dockspace()

        -- draw node tree
        imgui.Begin("Cursor")
        -- self:draw_node(ffi.cast("void *", 1), self.root)
        if root then
            self.table:draw(root, accessor)
        end
        imgui.End()

        imgui.Begin("Down")
        imgui.End()
    end,
}
GuiClangViewer.new = function()
    return new(GuiClangViewer, {
        dockspace_flags = const.ImGuiDockNodeFlags_.PassthruCentralNode,
        first_time = true,
        dockspace_id = ffi.new("ImGuiID[1]"),
        clear_color = ffi.new("float[4]", 0.45, 0.55, 0.6, 1),
    })
end

local app = require("app")
local TITLE = "ClangViewer"
if not app:initialize(1200, 900, TITLE) then
    os.exit(1)
end

local uv = require("luv")

-- enqueue task
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

local gui = GuiClangViewer.new()
gui.table = GuiTable.new("cursor_table")
gui.table.columns = {
    Column.new("spelling", const.ImGuiTableColumnFlags_.NoHide),
    Column.new("cursor", const.ImGuiTableColumnFlags_.WidthFixed, 8.0),
    Column.new("header", const.ImGuiTableColumnFlags_.WidthFixed, 12.0),
    Column.new("line", const.ImGuiTableColumnFlags_.WidthFixed, 4.0),
}

-- Main loop
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
                return node.spelling
            elseif i == 2 then
                return tostring(node.cursor_kind)
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
    })
    app:render(gui.clear_color)
end)

uv.run("default")
