local ffi = require("ffi")
local bit = require("bit")
local imgui_ffi = require("imgui_ffi.mod")
local const = imgui_ffi.enums
local imgui = imgui_ffi.libs.imgui
local utils = require("limgui.utils")

local M = {}

---@class GuiDockNode
---@field dir number
---@field framction number
M.DockNode = {
    split = function(self, dockspace_id)
        self.dock_id = imgui.DockBuilderSplitNode(dockspace_id[0], self.dir, self.fraction, nil, dockspace_id)
        imgui.DockBuilderDockWindow(self.name, self.dock_id)
    end,
}
M.DockNode.new = function(name, dir, fraction)
    return utils.new(M.DockNode, {
        name = name,
        dir = dir,
        fraction = fraction,
    })
end

---@class GuiDockSpace
---@field name string
---@field first_time boolean
---@field dockspace_flags number
---@field nodes GuiDockNode[]
M.GuiDockSpace = {
    draw = function(self)
        local viewport = imgui.GetMainViewport()
        imgui.SetNextWindowPos(viewport.Pos)
        imgui.SetNextWindowSize(viewport.Size)
        imgui.SetNextWindowViewport(viewport.ID)
        imgui.PushStyleVar(const.ImGuiStyleVar_.WindowRounding, 0.0)
        imgui.PushStyleVar(const.ImGuiStyleVar_.WindowBorderSize, 0.0)

        -- When using ImGuiDockNodeFlags_PassthruCentralNode, DockSpace() will render our background and handle the pass-thru hole, so we ask Begin() to not render a background.
        local window_flags = self.window_flags
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
            self.dockspace_id[0] = imgui.GetID(self.name)
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

                for i, node in ipairs(self.nodes) do
                    node:split(self.dockspace_id)
                end

                imgui.DockBuilderFinish(self.dockspace_id[0])
            end
        end

        imgui.End()
    end,
}
M.GuiDockSpace.new = function(name, nodes)
    -- We are using the ImGuiWindowFlags_NoDocking flag to make the parent window not dockable into,
    -- because it would be confusing to have two docking targets within each others.
    local window_flags = bit.bor(const.ImGuiWindowFlags_.MenuBar, const.ImGuiWindowFlags_.NoDocking)
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

    return utils.new(M.GuiDockSpace, {
        window_flags = window_flags,
        name = name,
        first_time = true,
        dockspace_id = ffi.new("ImGuiID[1]"),
        dockspace_flags = const.ImGuiDockNodeFlags_.PassthruCentralNode,
        nodes = nodes,
    })
end

return M
