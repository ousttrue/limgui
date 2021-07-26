-- C:/Users/oustt/ghq/github.com/ousttrue/limgui/libs/glfw/deps/glad/gl.h
local ffi = require 'ffi'
ffi.cdef[[
typedef void(*GLADapiproc)();
typedef GLADapiproc(*GLADloadfunc)(const char* name);
typedef GLADapiproc(*GLADuserptrloadfunc)(const char* name, void* userptr);
int gladLoadGLUserPtr(
    GLADuserptrloadfunc load,
    void* userptr
) asm("gladLoadGLUserPtr");
int gladLoadGL(
    GLADloadfunc load
) asm("gladLoadGL");
]]
