local ffi = require "ffi"
local imgui_ffi = require "imgui_ffi.mod"
local imgui = imgui_ffi.libs.imgui

---@class GUIExampleGlfwGl3
local gui = {
    show_demo_window = ffi.new("bool[1]", true),
    show_another_window = ffi.new "bool[1]",
    clear_color = ffi.new("float[4]", 0.45, 0.55, 0.6, 1),
    f = ffi.new "float[1]",
    counter = ffi.new("long long[1]", 1),

    ---@param self GUIExampleGlfwGl3
    update = function(self)
        -- 1. Show the big demo window (Most of the sample code is in imgui.ShowDemoWindow()! You can browse its code to learn more about Dear ImGui!).
        if self.show_demo_window[0] then
            imgui.ShowDemoWindow(self.show_demo_window)
        end

        -- 2. Show a simple window that we create ourselves. We use a Begin/End pair to created a named window.
        do
            imgui.Begin "Hello, world!"

            imgui.Text "This is some useful text."
            imgui.Checkbox("Demo Window", self.show_demo_window) -- Edit bools storing our window open/close state
            imgui.Checkbox("Another Window", self.show_another_window)

            imgui.SliderFloat("float", self.f, 0.0, 1.0) -- Edit 1 float using a slider from 0.0f to 1.0f
            imgui.ColorEdit3("clear color", self.clear_color) -- Edit 3 floats representing a color

            if imgui.Button "Button" then -- Buttons return true when clicked (most widgets return true when edited/activated)
                self.counter[0] = self.counter[0] + 1
            end
            imgui.SameLine()
            imgui.Text("counter = %d", self.counter[0])

            imgui.Text(
                "Application average %.3f ms/frame (%.1f FPS)",
                1000.0 / imgui.GetIO().Framerate,
                imgui.GetIO().Framerate
            )
            imgui.End()
        end

        -- 3. Show another simple window.
        if self.show_another_window[0] then
            imgui.Begin("Another Window", self.show_another_window) -- Pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
            imgui.Text "Hello from another window!"
            if imgui.Button "Close Me" then
                self.show_another_window[0] = false
            end
            imgui.End()
        end
    end,
}

local app = require "app"
local TITLE = "Dear ImGui GLFW+OpenGL3 example"
if not app:initialize(1200, 900, TITLE) then
    os.exit(1)
end

local render = require("engine.init").Renderer.new()

-- Main loop
while app:new_frame() do
    gui:update()
    local width, height = app.window:getFramebufferSize()
    render:clear(width, height, gui.clear_color)
    app:render()
end
