print(package.path)

local ffi = require("ffi")
local bit = require("bit")
local imgui_ffi = require("imgui_ffi.mod")
local imgui = imgui_ffi.libs.imgui
local const = imgui_ffi.enums
local CommandLine = require("clangffi.commandline")
local Parser = require("clangffi.parser")

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

    ---@param self GuiClangViewer
    update = function(self)
        self:dockspace()

        -- draw node tree
        imgui.Begin("Cursor")
        imgui.SetNextItemOpen(true, const.ImGuiCond_.ImGuiCond_Once)
        self:draw_node(ffi.cast("void *", 1), self.root)
        imgui.End()

        imgui.Begin("Down")
        imgui.Text("Hello, down!")
        imgui.End()
    end,
}

local cmd = CommandLine.parse({ ... })
local parser = Parser.new()
parser:parse(cmd.EXPORTS, cmd.CFLAGS)
print(parser.node_count)

print("remove_duplicated...")
local count = parser.root:remove_duplicated()
print(count)

local app = require("app")
local TITLE = "ClangViewer"
if not app:initialize(1200, 900, TITLE) then
    os.exit(1)
end

gui.root = parser.root

-- Main loop
while app:new_frame() do
    gui:update()
    app:render(gui.clear_color)
end
