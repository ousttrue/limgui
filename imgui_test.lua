-- Load libraries
local lj_glfw = require("glfw")
local gllib = require("gl")
gllib.set_loader(lj_glfw)
local ffi = require("ffi")
local bit = require("bit")
-- Localize the FFI libraries
local gl, glc, glu, glext = gllib.libraries()

print(lj_glfw.glfwVersionString())

lj_glfw.setErrorCallback(function(error, description)
	print("GLFW error:", error, ffi.string(description or ""))
end)

-- Initialize GLFW. Unline glfwInit, this throws an error on failure
lj_glfw.init()

local const = lj_glfw.glfwc

-- GL 3.0 + GLSL 130
-- const char* glsl_version = "#version 130";
lj_glfw.hint(const.GLFW_CONTEXT_VERSION_MAJOR, 3)
lj_glfw.hint(const.GLFW_CONTEXT_VERSION_MINOR, 0)
-- glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);  // 3.2+ only
-- glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);            // 3.0+ only

-- Create window with graphics context
local window = lj_glfw.Window(1280, 720, "Dear ImGui GLFW+OpenGL3 example", nil, nil);
-- if window == NULL
--     return 1;
window:makeContextCurrent()
lj_glfw.swapInterval(1); -- Enable vsync

-- Initialize OpenGL loader
-- #if defined(IMGUI_IMPL_OPENGL_LOADER_GL3W)
--     bool err = gl3wInit() != 0;
-- #elif defined(IMGUI_IMPL_OPENGL_LOADER_GLEW)
--     bool err = glewInit() != GLEW_OK;
-- #elif defined(IMGUI_IMPL_OPENGL_LOADER_GLAD)
--     bool err = gladLoadGL() == 0;
-- #elif defined(IMGUI_IMPL_OPENGL_LOADER_GLAD2)
--     bool err = gladLoadGL(glfwGetProcAddress) == 0; // glad2 recommend using the windowing library loader instead of the (optionally) bundled one.
-- #elif defined(IMGUI_IMPL_OPENGL_LOADER_GLBINDING2)
--     bool err = false;
--     glbinding::Binding::initialize();
-- #elif defined(IMGUI_IMPL_OPENGL_LOADER_GLBINDING3)
--     bool err = false;
--     glbinding::initialize([](const char* name) { return (glbinding::ProcAddress)glfwGetProcAddress(name); });
-- #else
--     bool err = false; // If you use IMGUI_IMPL_OPENGL_LOADER_CUSTOM, your loader is likely to requires some form of initialization.
-- #endif
--     if (err)
--     {
--         fprintf(stderr, "Failed to initialize OpenGL loader!\n");
--         return 1;
--     }

ffi.cdef[[
void* CreateContext(void* shared_font_atlas) asm("?CreateContext@ImGui@@YAPEAUImGuiContext@@PEAUImFontAtlas@@@Z");
]]
local imgui = ffi.load('imgui')

--     // Setup Dear ImGui context
--     IMGUI_CHECKVERSION();
       local context = imgui.CreateContext(nil);
       local a=0
--     ImGuiIO& io = ImGui::GetIO(); (void)io;
--     //io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;     // Enable Keyboard Controls
--     //io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;      // Enable Gamepad Controls

--     // Setup Dear ImGui style
--     ImGui::StyleColorsDark();
--     //ImGui::StyleColorsClassic();

--     // Setup Platform/Renderer backends
--     ImGui_ImplGlfw_InitForOpenGL(window, true);
--     ImGui_ImplOpenGL3_Init(glsl_version);

--     // Load Fonts
--     // - If no fonts are loaded, dear imgui will use the default font. You can also load multiple fonts and use ImGui::PushFont()/PopFont() to select them.
--     // - AddFontFromFileTTF() will return the ImFont* so you can store it if you need to select the font among multiple.
--     // - If the file cannot be loaded, the function will return NULL. Please handle those errors in your application (e.g. use an assertion, or display an error and quit).
--     // - The fonts will be rasterized at a given size (w/ oversampling) and stored into a texture when calling ImFontAtlas::Build()/GetTexDataAsXXXX(), which ImGui_ImplXXXX_NewFrame below will call.
--     // - Read 'docs/FONTS.md' for more instructions and details.
--     // - Remember that in C/C++ if you want to include a backslash \ in a string literal you need to write a double backslash \\ !
--     //io.Fonts->AddFontDefault();
--     //io.Fonts->AddFontFromFileTTF("../../misc/fonts/Roboto-Medium.ttf", 16.0f);
--     //io.Fonts->AddFontFromFileTTF("../../misc/fonts/Cousine-Regular.ttf", 15.0f);
--     //io.Fonts->AddFontFromFileTTF("../../misc/fonts/DroidSans.ttf", 16.0f);
--     //io.Fonts->AddFontFromFileTTF("../../misc/fonts/ProggyTiny.ttf", 10.0f);
--     //ImFont* font = io.Fonts->AddFontFromFileTTF("c:\\Windows\\Fonts\\ArialUni.ttf", 18.0f, NULL, io.Fonts->GetGlyphRangesJapanese());
--     //IM_ASSERT(font != NULL);

--     // Our state
--     bool show_demo_window = true;
--     bool show_another_window = false;
--     ImVec4 clear_color = ImVec4(0.45f, 0.55f, 0.60f, 1.00f);

--     // Main loop
--     while (!glfwWindowShouldClose(window))
--     {
--         // Poll and handle events (inputs, window resize, etc.)
--         // You can read the io.WantCaptureMouse, io.WantCaptureKeyboard flags to tell if dear imgui wants to use your inputs.
--         // - When io.WantCaptureMouse is true, do not dispatch mouse input data to your main application.
--         // - When io.WantCaptureKeyboard is true, do not dispatch keyboard input data to your main application.
--         // Generally you may always pass all inputs to dear imgui, and hide them from your application based on those two flags.
--         glfwPollEvents();

--         // Start the Dear ImGui frame
--         ImGui_ImplOpenGL3_NewFrame();
--         ImGui_ImplGlfw_NewFrame();
--         ImGui::NewFrame();

--         // 1. Show the big demo window (Most of the sample code is in ImGui::ShowDemoWindow()! You can browse its code to learn more about Dear ImGui!).
--         if (show_demo_window)
--             ImGui::ShowDemoWindow(&show_demo_window);

--         // 2. Show a simple window that we create ourselves. We use a Begin/End pair to created a named window.
--         {
--             static float f = 0.0f;
--             static int counter = 0;

--             ImGui::Begin("Hello, world!");                          // Create a window called "Hello, world!" and append into it.

--             ImGui::Text("This is some useful text.");               // Display some text (you can use a format strings too)
--             ImGui::Checkbox("Demo Window", &show_demo_window);      // Edit bools storing our window open/close state
--             ImGui::Checkbox("Another Window", &show_another_window);

--             ImGui::SliderFloat("float", &f, 0.0f, 1.0f);            // Edit 1 float using a slider from 0.0f to 1.0f
--             ImGui::ColorEdit3("clear color", (float*)&clear_color); // Edit 3 floats representing a color

--             if (ImGui::Button("Button"))                            // Buttons return true when clicked (most widgets return true when edited/activated)
--                 counter++;
--             ImGui::SameLine();
--             ImGui::Text("counter = %d", counter);

--             ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", 1000.0f / ImGui::GetIO().Framerate, ImGui::GetIO().Framerate);
--             ImGui::End();
--         }

--         // 3. Show another simple window.
--         if (show_another_window)
--         {
--             ImGui::Begin("Another Window", &show_another_window);   // Pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
--             ImGui::Text("Hello from another window!");
--             if (ImGui::Button("Close Me"))
--                 show_another_window = false;
--             ImGui::End();
--         }

--         // Rendering
--         ImGui::Render();
--         int display_w, display_h;
--         glfwGetFramebufferSize(window, &display_w, &display_h);
--         glViewport(0, 0, display_w, display_h);
--         glClearColor(clear_color.x * clear_color.w, clear_color.y * clear_color.w, clear_color.z * clear_color.w, clear_color.w);
--         glClear(GL_COLOR_BUFFER_BIT);
--         ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());

--         glfwSwapBuffers(window);
--     }

--     // Cleanup
--     ImGui_ImplOpenGL3_Shutdown();
--     ImGui_ImplGlfw_Shutdown();
--     ImGui::DestroyContext();

--     glfwDestroyWindow(window);
--     glfwTerminate();

--     return 0;
-- }
