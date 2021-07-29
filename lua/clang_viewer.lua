print(package.path)

-- TODO
-- T | source |
-- R |        |
-- E +--------+
-- E | prop   |
--
-- * [ ] filter: cursor kind
-- * [ ] central: source
-- * [ ] selection: location
-- * [ ] node: type kind
-- * [ ] node: jump reference

local ffi = require("ffi")
local bit = require("bit")
local imgui_ffi = require("imgui_ffi.mod")
local imgui = imgui_ffi.libs.imgui
local const = imgui_ffi.enums

---@class Table
local Table = {
    flags = bit.bor(
        const.ImGuiTableFlags_.ImGuiTableFlags_BordersV,
        const.ImGuiTableFlags_.ImGuiTableFlags_BordersOuterH,
        const.ImGuiTableFlags_.ImGuiTableFlags_Resizable,
        const.ImGuiTableFlags_.ImGuiTableFlags_RowBg,
        const.ImGuiTableFlags_.ImGuiTableFlags_NoBordersInBody
    ),

    draw_node = function(self, node)
        imgui.TableNextRow()
        imgui.TableNextColumn()

        if node.Children then
            local open = imgui.TreeNodeEx(node.Name, const.ImGuiTreeNodeFlags_.ImGuiTreeNodeFlags_SpanFullWidth)
            imgui.TableNextColumn()
            imgui.TextDisabled("--")
            imgui.TableNextColumn()
            imgui.TextUnformatted(node.Type)
            if open then
                for i, child in ipairs(node.Children) do
                    self:draw_node(child)
                end
                imgui.TreePop()
            end
        else
            imgui.TreeNodeEx(
                node.Name,
                bit.bor(
                    const.ImGuiTreeNodeFlags_.ImGuiTreeNodeFlags_Leaf,
                    const.ImGuiTreeNodeFlags_.ImGuiTreeNodeFlags_Bullet,
                    const.ImGuiTreeNodeFlags_.ImGuiTreeNodeFlags_NoTreePushOnOpen,
                    const.ImGuiTreeNodeFlags_.ImGuiTreeNodeFlags_SpanFullWidth
                )
            )
            imgui.TableNextColumn()
            imgui.Text("%d", node.Size)
            imgui.TableNextColumn()
            imgui.TextUnformatted(node.Type)
        end
    end,

    ---@param self Table
    ---@param root any
    draw = function(self, root)
        if not self.TEXT_BASE_WIDTH then
            self.TEXT_BASE_WIDTH = imgui.CalcTextSize("A").x
        end

        if imgui.BeginTable("3ways", 3, self.flags) then
            -- The first column will use the default _WidthStretch when ScrollX is Off and _WidthFixed when ScrollX is On
            imgui.TableSetupColumn("Name", const.ImGuiTableColumnFlags_.ImGuiTableColumnFlags_NoHide)
            imgui.TableSetupColumn(
                "Size",
                const.ImGuiTableColumnFlags_.ImGuiTableColumnFlags_WidthFixed,
                self.TEXT_BASE_WIDTH * 12.0
            )
            imgui.TableSetupColumn(
                "Type",
                const.ImGuiTableColumnFlags_.ImGuiTableColumnFlags_WidthFixed,
                self.TEXT_BASE_WIDTH * 18.0
            )
            imgui.TableHeadersRow()

            self:draw_node(root)

            imgui.EndTable()
        end
    end,
}

--- https://gist.github.com/PossiblyAShrub/0aea9511b84c34e191eaa90dd7225969
---@class GuiClangViewer
---@field clear_color any
local gui = {
    dockspace_flags = const.ImGuiDockNodeFlags_.ImGuiDockNodeFlags_PassthruCentralNode,
    first_time = true,
    dockspace_id = ffi.new("ImGuiID[1]"),
    clear_color = ffi.new("float[4]", 0.45, 0.55, 0.6, 1),

    dockspace = function(self)
        -- We are using the ImGuiWindowFlags_NoDocking flag to make the parent window not dockable into,
        -- because it would be confusing to have two docking targets within each others.
        local window_flags = bit.bor(
            const.ImGuiWindowFlags_.ImGuiWindowFlags_MenuBar,
            const.ImGuiWindowFlags_.ImGuiWindowFlags_NoDocking
        )

        local viewport = imgui.GetMainViewport()
        imgui.SetNextWindowPos(viewport.Pos)
        imgui.SetNextWindowSize(viewport.Size)
        imgui.SetNextWindowViewport(viewport.ID)
        imgui.PushStyleVar(const.ImGuiStyleVar_.ImGuiStyleVar_WindowRounding, 0.0)
        imgui.PushStyleVar(const.ImGuiStyleVar_.ImGuiStyleVar_WindowBorderSize, 0.0)
        window_flags = bit.bor(
            window_flags,
            const.ImGuiWindowFlags_.ImGuiWindowFlags_NoTitleBar,
            const.ImGuiWindowFlags_.ImGuiWindowFlags_NoCollapse,
            const.ImGuiWindowFlags_.ImGuiWindowFlags_NoResize,
            const.ImGuiWindowFlags_.ImGuiWindowFlags_NoMove
        )
        window_flags = bit.bor(
            window_flags,
            const.ImGuiWindowFlags_.ImGuiWindowFlags_NoBringToFrontOnFocus,
            const.ImGuiWindowFlags_.ImGuiWindowFlags_NoNavFocus
        )

        -- When using ImGuiDockNodeFlags_PassthruCentralNode, DockSpace() will render our background and handle the pass-thru hole, so we ask Begin() to not render a background.
        if bit.band(self.dockspace_flags, const.ImGuiDockNodeFlags_.ImGuiDockNodeFlags_PassthruCentralNode) ~= 0 then
            window_flags = bit.bor(window_flags, const.ImGuiWindowFlags_.ImGuiWindowFlags_NoBackground)
        end

        -- Important: note that we proceed even if Begin() returns false (aka window is collapsed).
        -- This is because we want to keep our DockSpace() active. If a DockSpace() is inactive,
        -- all active windows docked into it will lose their parent and become undocked.
        -- We cannot preserve the docking relationship between an active window and an inactive docking, otherwise
        -- any change of dockspace/settings would lead to windows being stuck in limbo and never being visible.
        imgui.PushStyleVar__1(const.ImGuiStyleVar_.ImGuiStyleVar_WindowPadding, ffi.new("struct ImVec2"))
        imgui.Begin("DockSpace", nil, window_flags)
        imgui.PopStyleVar()
        imgui.PopStyleVar(2)

        -- DockSpace
        local io = imgui.GetIO()
        io.ConfigFlags = bit.bor(io.ConfigFlags, const.ImGuiConfigFlags_.ImGuiConfigFlags_DockingEnable)
        if bit.band(io.ConfigFlags, const.ImGuiConfigFlags_.ImGuiConfigFlags_DockingEnable) ~= 0 then
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
                    const.ImGuiDir_.ImGuiDir_Left,
                    0.2,
                    nil,
                    self.dockspace_id
                )
                local dock_id_down = imgui.DockBuilderSplitNode(
                    self.dockspace_id[0],
                    const.ImGuiDir_.ImGuiDir_Down,
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
    ---@param node Node
    draw_node = function(self, i, node)
        if node.children then
            if imgui.TreeNode__2(i, node.spelling) then
                for j, child in ipairs(node.children) do
                    self:draw_node(ffi.cast("void *", j), child)
                end
                imgui.TreePop()
            end
        else
            imgui.BulletText(node.spelling)
        end
    end,

    sample_node = {
        Name = "Root",
        Type = "Folder",
        Size = -1,
        Children = {
            {
                Name = "Music",
                Type = "Folder",
                Size = -1,
                Children = {
                    { Name = "File1_a.wav", Type = "Audio file", Size = 123000 },
                    { Name = "File1_b.wav", Type = "Audio file", Size = 456000 },
                },
            },
            {
                Name = "Textures",
                Type = "Folder",
                Size = -1,
                Children = {
                    { Name = "Image001.png", Type = "Image file", Size = 203128 },
                    { Name = "Copy of Image001.png", Type = "Image file", Size = 203256 },
                    { Name = "Copy of Image001 (Final2).png", Type = "Image file", Size = 203512 },
                },
            },
            { Name = "desktop.ini", Type = "System file", Size = 1024 },
        },
    },

    ---@param self GuiClangViewer
    update = function(self)
        self:dockspace()

        -- draw node tree
        imgui.Begin("Cursor")
        if self.root then
            imgui.SetNextItemOpen(true, const.ImGuiCond_.ImGuiCond_Once)
            self:draw_node(ffi.cast("void *", 1), self.root)
        end
        imgui.End()

        imgui.Begin("Down")
        Table:draw(self.sample_node)
        imgui.End()
    end,
}

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
local function on_end(dst, src)
    local offset, root = mp.unpack(dst)
    gui.root = root
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
local idle = uv.new_idle()
idle:start(function()
    if not app:new_frame() then
        idle:stop()
    end
    gui:update()
    app:render(gui.clear_color)
end)

uv.run("default")
