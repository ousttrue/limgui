local glfw = require("gl_ffi.glfw")
local glfwc = glfw.glfwc
local imgui_ffi = require("imgui_ffi.mod")
local glad = imgui_ffi.libs.glad
local imgui = imgui_ffi.libs.imgui

-- GL 3.0 + GLSL 130
local GLSL_VERSION = "#version 130"

local function glfw_error_callback(error, description)
    print(string.format("Glfw Error %d: %s\n", error, description))
end

local gl, glc, glu, glext

---@class AppClangViewer
---@field window any
local app = {
    ---@param self AppClangViewer
    ---@return boolean
    initialize = function(self, w, h, title)
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
        self.window = glfw.Window:__new(w, h, TITLE, nil, nil)
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
        imgui.ImGui_ImplOpenGL3_Init(GLSL_VERSION)

        -- Load Fonts
        local font = imgui.ImFontAtlas_AddFontFromFileTTF(
            self.io.Fonts,
            "c:\\Windows\\Fonts\\meiryo.ttc",
            24.0,
            nil,
            imgui.ImFontAtlas_GetGlyphRangesJapanese(self.io.Fonts)
        )
        assert(font)

        -- finalizer
        self.finalizer = newproxy(true)
        getmetatable(self.finalizer).__gc = function()
            print("shutdown...")
            imgui.ImGui_ImplOpenGL3_Shutdown()
            imgui.ImGui_ImplGlfw_Shutdown()
            imgui.DestroyContext(nil)
            self.window:destroy()
            glfw.terminate()
        end

        return true
    end,

    ---@param self AppClangViewer
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

    ---@param self AppClangViewer
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

return app
