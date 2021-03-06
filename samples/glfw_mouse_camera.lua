local ffi = require "ffi"
local glfw = require "gl_ffi.glfw"
local glfwc = glfw.glfwc
local utils = require "limgui.utils"
local engine = require "engine.init"
local scene = require "scene.init"
local maf = require "mafex"
local math = require "math"

--
-- scene
--

local vs = [[#version 400
in vec2 vPos;
in vec3 vCol;
uniform mat4 MVP;
out vec3 Color;

void main()
{
    gl_Position = MVP * vec4(vPos, 0.0, 1.0);
    Color = vCol;
};
]]

local fs = [[#version 400
in vec3 Color;
out vec4 FragColor;

void main()
{
    FragColor = vec4(Color, 1.0);
};
]]

ffi.cdef [[
struct Vertex2DRGB
{
    float x, y;
    float r, g, b;
};
]]
local vertices = ffi.new(
    "struct Vertex2DRGB[3]",
    { -0.6, -0.4, 1., 0., 0. },
    { 0.6, -0.4, 0., 1., 0. },
    { 0., 0.6, 0., 0., 1. }
)
assert(vertices[2].b == 1.0)

--
-- glfw setup
--

glfw.setErrorCallback(function(error, description)
    print(string.format("Error: %s\n", description))
end)
if glfw.init() == 0 then
    assert(false)
end
local window = glfw.Window:__new(640, 480, "MouseCamera", nil, nil)
if not window then
    glfw.terminate()
    assert(false)
end

window:setKeyCallback(function(window, key, scancode, action, mods)
    if key == glfwc.GLFW_KEY_ESCAPE and action == glfwc.GLFW_PRESS then
        window:setShouldClose(true)
    end
end)

--- camera
local w, h = window:getSize()
local camera = engine.OrbitCamera.new(w, h)

-- bind event
window:setCursorPosCallback(function(window, x, y)
    camera:mouse_move(x, y)
end)
window:setMouseButtonCallback(function(window, button, is_down)
    camera:mouse_button(button, is_down ~= 0)
end)
window:setScrollCallback(function(window, x, y)
    camera:mouse_wheel(y)
end)
window:setSizeCallback(function(window, w, h)
    camera:resize(w, h)
end)

--- opengl
glfw.hint(glfwc.GLFW_CONTEXT_VERSION_MAJOR, 4)
glfw.hint(glfwc.GLFW_CONTEXT_VERSION_MINOR, 0)
glfw.hint(glfwc.GLFW_OPENGL_PROFILE, glfwc.GLFW_OPENGL_CORE_PROFILE)
window:makeContextCurrent()
glfw.swapInterval(1)
local gl = require "gl_ffi.mod"
gl.load(glfw)
local function gl_string(key)
    local p = gl.glGetString(key)
    return ffi.string(ffi.cast("const char*", p))
end
print(gl_string(gl.GL_RENDERER))
print(gl_string(gl.GL_VENDOR))
print(gl_string(gl.GL_VERSION))
print(gl_string(gl.GL_SHADING_LANGUAGE_VERSION))

--
-- scene setup
--

local mesh = utils.new(scene.Mesh, {
    vertices = vertices,
    vertex_count = 3,
    vertex_stride = 20,
    shader = {
        vs = vs,
        fs = fs,
    },
})
local clear_color = ffi.new("float[4]", 0.2, 0.3, 0.4, 1.0)

--
-- main loop
--
local renderer = engine.Renderer.new()
while not window:shouldClose(window) do
    -- update
    local width, height = window:getFramebufferSize()

    -- render
    renderer:clear(width, height, clear_color)
    renderer:render(mesh, {
        MVP = camera:matrix().array,
    })
    window:swapBuffers()
    glfw.pollEvents()
end
glfw.terminate()
