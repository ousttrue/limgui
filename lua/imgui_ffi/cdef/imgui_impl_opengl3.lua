-- generated from imgui_impl_opengl3.h
local ffi = require 'ffi'
ffi.cdef[[
bool ImGui_ImplOpenGL3_Init(
    const char* glsl_version
) asm("?ImGui_ImplOpenGL3_Init@@YA_NPEBD@Z");
void ImGui_ImplOpenGL3_Shutdown(
) asm("?ImGui_ImplOpenGL3_Shutdown@@YAXXZ");
void ImGui_ImplOpenGL3_NewFrame(
) asm("?ImGui_ImplOpenGL3_NewFrame@@YAXXZ");
void ImGui_ImplOpenGL3_RenderDrawData(
    struct ImDrawData* draw_data
) asm("?ImGui_ImplOpenGL3_RenderDrawData@@YAXPEAUImDrawData@@@Z");
bool ImGui_ImplOpenGL3_CreateFontsTexture(
) asm("?ImGui_ImplOpenGL3_CreateFontsTexture@@YA_NXZ");
void ImGui_ImplOpenGL3_DestroyFontsTexture(
) asm("?ImGui_ImplOpenGL3_DestroyFontsTexture@@YAXXZ");
bool ImGui_ImplOpenGL3_CreateDeviceObjects(
) asm("?ImGui_ImplOpenGL3_CreateDeviceObjects@@YA_NXZ");
void ImGui_ImplOpenGL3_DestroyDeviceObjects(
) asm("?ImGui_ImplOpenGL3_DestroyDeviceObjects@@YAXXZ");
]]
