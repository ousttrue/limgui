local ffi = require("ffi")
local bit = require("bit")
local glfw = require("glfw")
local glfwc = glfw.glfwc
local imgui_ffi = require("imgui_ffi.mod")
local glad = imgui_ffi.libs.glad
local imgui = imgui_ffi.libs.imgui
local const = imgui_ffi.enums

-- GL 3.0 + GLSL 130
local glsl_version = "#version 130"

local function glfw_error_callback(error, description)
    print(string.format("Glfw Error %d: %s\n", error, description))
end

local gl, glc, glu, glext

---@class App
---@field window any
local app = {
    ---@param self App
    ---@return boolean
    initialize = function(self, w, h)
        -- Setup window
        glfw.setErrorCallback(glfw_error_callback)
        if not glfw.init() == 0 then
            return false
        end

        -- Decide GL+GLSL versions
        glfw.hint(glfwc.GLFW_CONTEXT_VERSION_MAJOR, 3)
        glfw.hint(glfwc.GLFW_CONTEXT_VERSION_MINOR, 0)
        --glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);  -- 3.2+ only
        --glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);            -- 3.0+ only

        -- Create window with graphics context
        self.window = glfw.Window:__new(w, h, "Dear ImGui GLFW+OpenGL3 example", nil, nil)
        if not self.window then
            assert(false)
        end

        self.window:makeContextCurrent()
        -- Initialize OpenGL loader
        glad.gladLoadGL(glfw.getProcAddress)
        local gllib = require("gl")
        gllib.set_loader(glfw)
        gl, glc, glu, glext = gllib.libraries()

        glfw.swapInterval(1) -- Enable vsync

        -- Setup Dear ImGui context
        imgui.CreateContext(nil)
        self.io = imgui.GetIO()
        --io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;     -- Enable Keyboard Controls
        --io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;      -- Enable Gamepad Controls

        -- Setup Dear ImGui style
        imgui.StyleColorsDark()
        -- imgui.StyleColorsClassic()

        -- Setup Platform/Renderer backends
        imgui.ImGui_ImplGlfw_InitForOpenGL(self.window, true)
        imgui.ImGui_ImplOpenGL3_Init(glsl_version)

        -- Load Fonts
        -- - If no fonts are loaded, dear imgui will use the default font. You can also load multiple fonts and use imgui.PushFont()/PopFont() to select them.
        -- - AddFontFromFileTTF() will return the ImFont* so you can store it if you need to select the font among multiple.
        -- - If the file cannot be loaded, the function will return NULL. Please handle those errors in your application (e.g. use an assertion, or display an error and quit).
        -- - The fonts will be rasterized at a given size (w/ oversampling) and stored into a texture when calling ImFontAtlas::Build()/GetTexDataAsXXXX(), which ImGui_ImplXXXX_NewFrame below will call.
        -- - Read 'docs/FONTS.md' for more instructions and details.
        -- - Remember that in C/C++ if you want to include a backslash \ in a string literal you need to write a double backslash \\ !
        -- imgui.ImFontAtlas_AddFontDefault(io.Fonts)
        -- imgui.ImFontAtlas_AddFontFromFileTTF(self.io.Fonts, "C:/Windows/Fonts/meiryo.ttc", 16.0)
        --io.Fonts->AddFontFromFileTTF("../../misc/fonts/Cousine-Regular.ttf", 15.0f);
        --io.Fonts->AddFontFromFileTTF("../../misc/fonts/DroidSans.ttf", 16.0f);
        --io.Fonts->AddFontFromFileTTF("../../misc/fonts/ProggyTiny.ttf", 10.0f);
        local font = imgui.ImFontAtlas_AddFontFromFileTTF(
            self.io.Fonts,
            "c:\\Windows\\Fonts\\meiryo.ttc",
            24.0,
            nil,
            imgui.ImFontAtlas_GetGlyphRangesJapanese(self.io.Fonts)
        )
        assert(font)

        return true
    end,

    ---@param self App
    ---@return boolean
    new_frame = function(self)
        if self.window:shouldClose(self.window) then
            return false
        end

        -- Poll and handle events (inputs, window resize, etc.)
        -- You can read the io.WantCaptureMouse, io.WantCaptureKeyboard flags to tell if dear imgui wants to use your inputs.
        -- - When io.WantCaptureMouse is true, do not dispatch mouse input data to your main application.
        -- - When io.WantCaptureKeyboard is true, do not dispatch keyboard input data to your main application.
        -- Generally you may always pass all inputs to dear imgui, and hide them from your application based on those two flags.
        glfw.pollEvents()

        -- Start the Dear ImGui frame
        imgui.ImGui_ImplOpenGL3_NewFrame()
        imgui.ImGui_ImplGlfw_NewFrame()
        imgui.NewFrame()

        return true
    end,

    ---@param self App
    ---@param clear_color any
    render = function(self, clear_color)
        -- Rendering
        imgui.Render()

        local display_w, display_h = self.window:getFramebufferSize()
        gl.glViewport(0, 0, display_w, display_h)
        gl.glClearColor(
            clear_color[0] * clear_color[3],
            clear_color[1] * clear_color[3],
            clear_color[2] * clear_color[3],
            clear_color[3]
        )
        gl.glClear(glc.GL_COLOR_BUFFER_BIT)
        imgui.ImGui_ImplOpenGL3_RenderDrawData(imgui.GetDrawData())

        self.window:swapBuffers()
    end,
}

-- finalizer
local scope = newproxy(true)
getmetatable(scope).__gc = function()
    print("shutdown...")
    imgui.ImGui_ImplOpenGL3_Shutdown()
    imgui.ImGui_ImplGlfw_Shutdown()
    imgui.DestroyContext(nil)
    app.window:destroy()
    glfw.terminate()
end

--- https://gist.github.com/PossiblyAShrub/0aea9511b84c34e191eaa90dd7225969
---@class GUI
---@field show_demo_window any
---@field show_another_window any
---@field clear_color any
---@field f any
---@field counter any
gui = {
    dockspace_flags = const.ImGuiDockNodeFlags_.ImGuiDockNodeFlags_PassthruCentralNode,
    first_time = true,
    dockspace_id = ffi.new("ImGuiID[1]"),

    clear_color = ffi.new("float[4]", 0.45, 0.55, 0.6, 1),

    ---@param self GUI
    update = function(self)
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

            if self.first_time then
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
                imgui.DockBuilderDockWindow("Left", dock_id_left)
                imgui.DockBuilderFinish(self.dockspace_id[0])
            end
        end

        imgui.End()

        imgui.Begin("Left")
        imgui.Text("Hello, left!")
        imgui.End()

        imgui.Begin("Down")
        imgui.Text("Hello, down!")
        imgui.End()
    end,
}

if not app:initialize(1200, 900) then
    assert(false)
end

-- Main loop
while app:new_frame() do
    gui:update()
    app:render(gui.clear_color)
end
