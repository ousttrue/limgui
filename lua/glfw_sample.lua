-- port from
--
-- * https://www.glfw.org/docs/latest/quick.html
--
local ffi = require("ffi")

local glfw = require("libs.gl_ffi.glfw")
local glfwc = glfw.glfwc

local function error_callback(error, description)
    print(string.format("Error: %s\n", description))
end

local function key_callback(window, key, scancode, action, mods)
    if key == glfwc.GLFW_KEY_ESCAPE and action == glfwc.GLFW_PRESS then
        glfw.setWindowShouldClose(window, glfwc.GLFW_TRUE)
    end
end

glfw.setErrorCallback(error_callback)

if glfw.init() == 0 then
    assert(false)
end

glfw.hint(glfwc.GLFW_CONTEXT_VERSION_MAJOR, 2)
glfw.hint(glfwc.GLFW_CONTEXT_VERSION_MINOR, 0)

local window = glfw.Window:__new(640, 480, "Simple example", nil, nil)
if not window then
    glfw.terminate()
    assert(false)
end

window:setKeyCallback(key_callback)

window:makeContextCurrent()
glfw.swapInterval(1)

local renderer = require("limgui.renderer")
local r = renderer.Renderer.new()

local clear_color = ffi.new("float[4]", 0.2, 0.3, 0.4, 1.0)
while not window:shouldClose(window) do
    local width, height = window:getFramebufferSize()
    renderer.clear(width, height, clear_color)
    r:render()
    window:swapBuffers()
    glfw.pollEvents()
end

glfw.terminate()
