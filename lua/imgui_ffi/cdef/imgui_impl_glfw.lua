-- generated from imgui_impl_glfw.h
local ffi = require 'ffi'
ffi.cdef[[
struct GLFWwindow;
struct GLFWmonitor;
bool ImGui_ImplGlfw_InitForOpenGL(
    struct GLFWwindow* window,
    bool install_callbacks
) asm("?ImGui_ImplGlfw_InitForOpenGL@@YA_NPEAUGLFWwindow@@_N@Z");
bool ImGui_ImplGlfw_InitForVulkan(
    struct GLFWwindow* window,
    bool install_callbacks
) asm("?ImGui_ImplGlfw_InitForVulkan@@YA_NPEAUGLFWwindow@@_N@Z");
bool ImGui_ImplGlfw_InitForOther(
    struct GLFWwindow* window,
    bool install_callbacks
) asm("?ImGui_ImplGlfw_InitForOther@@YA_NPEAUGLFWwindow@@_N@Z");
void ImGui_ImplGlfw_Shutdown(
) asm("?ImGui_ImplGlfw_Shutdown@@YAXXZ");
void ImGui_ImplGlfw_NewFrame(
) asm("?ImGui_ImplGlfw_NewFrame@@YAXXZ");
void ImGui_ImplGlfw_MouseButtonCallback(
    struct GLFWwindow* window,
    int button,
    int action,
    int mods
) asm("?ImGui_ImplGlfw_MouseButtonCallback@@YAXPEAUGLFWwindow@@HHH@Z");
void ImGui_ImplGlfw_ScrollCallback(
    struct GLFWwindow* window,
    double xoffset,
    double yoffset
) asm("?ImGui_ImplGlfw_ScrollCallback@@YAXPEAUGLFWwindow@@NN@Z");
void ImGui_ImplGlfw_KeyCallback(
    struct GLFWwindow* window,
    int key,
    int scancode,
    int action,
    int mods
) asm("?ImGui_ImplGlfw_KeyCallback@@YAXPEAUGLFWwindow@@HHHH@Z");
void ImGui_ImplGlfw_CharCallback(
    struct GLFWwindow* window,
    unsigned int c
) asm("?ImGui_ImplGlfw_CharCallback@@YAXPEAUGLFWwindow@@I@Z");
void ImGui_ImplGlfw_MonitorCallback(
    struct GLFWmonitor* monitor,
    int event
) asm("?ImGui_ImplGlfw_MonitorCallback@@YAXPEAUGLFWmonitor@@H@Z");
]]
