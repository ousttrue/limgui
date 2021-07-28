local ffi = require("ffi")
local glfw = require("gl_ffi.glfw")
local glfwc = glfw.glfwc
local imgui_ffi = require("imgui_ffi.mod")
local glad = imgui_ffi.libs.glad
local imgui = imgui_ffi.libs.imgui
local gl, glc, glu, glext

local function glfw_error_callback(error, description)
    print(string.format("Glfw Error %d: %s\n", error, description))
end

---@class ExampleGlfwGl3
---@field window any
local app = {
    ---@param self ExampleGlfwGl3
    ---@return boolean
    initialize = function(self)
        -- Setup window
        glfw.setErrorCallback(glfw_error_callback)
        if not glfw.init() == 0 then
            return false
        end

        -- Decide GL+GLSL versions
        -- GL 3.0 + GLSL 130
        glfw.hint(glfwc.GLFW_CONTEXT_VERSION_MAJOR, 3)
        glfw.hint(glfwc.GLFW_CONTEXT_VERSION_MINOR, 0)
        --glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);  -- 3.2+ only
        --glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);            -- 3.0+ only

        -- Create window with graphics context
        self.window = glfw.Window:__new(1280, 720, "Dear ImGui GLFW+OpenGL3 example", nil, nil)
        if not self.window then
            return false
        end
        self.window:makeContextCurrent()

        -- Initialize OpenGL loader
        glad.gladLoadGL(glfw.getProcAddress)
        local gllib = require("gl_ffi.gl")
        gllib.set_loader(glfw)
        gl, glc, glu, glext = gllib.libraries()

        glfw.swapInterval(1) -- Enable vsync

        return true
    end,

    ---@param self ExampleGlfwGl3
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

        return true
    end,

    ---@param self ExampleGlfwGl3
    ---@param clear_color any
    render = function(self, clear_color)
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

local scope = newproxy(true)
getmetatable(scope).__gc = function()
    print('shutdown...')
    imgui.ImGui_ImplOpenGL3_Shutdown()
    imgui.ImGui_ImplGlfw_Shutdown()
    imgui.DestroyContext(nil)
    app.window:destroy()
    glfw.terminate()
end

---@class GUIExampleGlfwGl3
local gui = {
    glsl_version = "#version 130",

    show_demo_window = ffi.new("bool[1]", true),
    show_another_window = ffi.new("bool[1]"),
    clear_color = ffi.new("float[4]", 0.45, 0.55, 0.6, 1),
    f = ffi.new("float[1]"),
    counter = ffi.new("long long[1]", 1),

    ---@param self GUIExampleGlfwGl3
    ---@param window any
    ---@return boolean
    initialize = function(self, window)
        -- Setup Dear ImGui context
        imgui.CreateContext(nil)
        local io = imgui.GetIO()
        --io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;     -- Enable Keyboard Controls
        --io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;      -- Enable Gamepad Controls

        -- Setup Dear ImGui style
        imgui.StyleColorsDark()
        --imgui.StyleColorsClassic();

        -- Setup Platform/Renderer backends
        imgui.ImGui_ImplGlfw_InitForOpenGL(window, true)
        imgui.ImGui_ImplOpenGL3_Init(self.glsl_version)

        -- Load Fonts
        -- - If no fonts are loaded, dear imgui will use the default font. You can also load multiple fonts and use imgui.PushFont()/PopFont() to select them.
        -- - AddFontFromFileTTF() will return the ImFont* so you can store it if you need to select the font among multiple.
        -- - If the file cannot be loaded, the function will return NULL. Please handle those errors in your application (e.g. use an assertion, or display an error and quit).
        -- - The fonts will be rasterized at a given size (w/ oversampling) and stored into a texture when calling ImFontAtlas::Build()/GetTexDataAsXXXX(), which ImGui_ImplXXXX_NewFrame below will call.
        -- - Read 'docs/FONTS.md' for more instructions and details.
        -- - Remember that in C/C++ if you want to include a backslash \ in a string literal you need to write a double backslash \\ !
        --io.Fonts->AddFontDefault();
        --io.Fonts->AddFontFromFileTTF("../../misc/fonts/Roboto-Medium.ttf", 16.0f);
        --io.Fonts->AddFontFromFileTTF("../../misc/fonts/Cousine-Regular.ttf", 15.0f);
        --io.Fonts->AddFontFromFileTTF("../../misc/fonts/DroidSans.ttf", 16.0f);
        --io.Fonts->AddFontFromFileTTF("../../misc/fonts/ProggyTiny.ttf", 10.0f);
        local font = imgui.ImFontAtlas_AddFontFromFileTTF(
            io.Fonts,
            "c:\\Windows\\Fonts\\Arial.ttf",
            24.0,
            nil,
            imgui.ImFontAtlas_GetGlyphRangesJapanese(io.Fonts)
        )
        if not font then
            return false
        end

        return true
    end,

    ---@param self GUIExampleGlfwGl3
    update = function(self)
        -- Start the Dear ImGui frame
        imgui.ImGui_ImplOpenGL3_NewFrame()
        imgui.ImGui_ImplGlfw_NewFrame()
        imgui.NewFrame()

        -- 1. Show the big demo window (Most of the sample code is in imgui.ShowDemoWindow()! You can browse its code to learn more about Dear ImGui!).
        if self.show_demo_window[0] then
            imgui.ShowDemoWindow(self.show_demo_window)
        end

        -- 2. Show a simple window that we create ourselves. We use a Begin/End pair to created a named window.
        do
            imgui.Begin("Hello, world!") -- Create a window called "Hello, world!" and append into it.

            imgui.Text("This is some useful text.") -- Display some text (you can use a format strings too)
            imgui.Checkbox("Demo Window", self.show_demo_window) -- Edit bools storing our window open/close state
            imgui.Checkbox("Another Window", self.show_another_window)

            imgui.SliderFloat("float", self.f, 0.0, 1.0) -- Edit 1 float using a slider from 0.0f to 1.0f
            imgui.ColorEdit3("clear color", self.clear_color) -- Edit 3 floats representing a color

            if imgui.Button("Button") then -- Buttons return true when clicked (most widgets return true when edited/activated)
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
            imgui.Text("Hello from another window!")
            if imgui.Button("Close Me") then
                self.show_another_window[0] = false
            end
            imgui.End()
        end

        -- Rendering
        imgui.Render()
    end,
}

if not app:initialize() then
    os.exit(1)
end
if not gui:initialize(app.window) then
    os.exit(2)
end

-- Main loop
while app:new_frame() do
    gui:update()
    app:render(gui.clear_color)
end
