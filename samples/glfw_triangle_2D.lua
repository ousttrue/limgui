-- port from
--
-- * https://www.glfw.org/docs/latest/quick.html
--

local ffi = require "ffi"
local glfw = require "gl_ffi.glfw"
local glfwc = glfw.glfwc
local utils = require "limgui.utils"

--
-- scene
--

local vs = [[#version 110
uniform mat4 MVP;
attribute vec2 vPos;
attribute vec3 vCol;
varying vec3 color;
void main()
{
    gl_Position = MVP * vec4(vPos, 0.0, 1.0);
    color = vCol;
};
]]

local fs = [[#version 110
varying vec3 color;
void main()
{
    gl_FragColor = vec4(color, 1.0);
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

-- init
if glfw.init() == 0 then
    assert(false)
end

-- window
glfw.hint(glfwc.GLFW_CONTEXT_VERSION_MAJOR, 3)
glfw.hint(glfwc.GLFW_CONTEXT_VERSION_MINOR, 0)
local window = glfw.Window:__new(640, 480, "Simple example", nil, nil)
if not window then
    glfw.terminate()
    assert(false)
end

window:setKeyCallback(function(window, key, scancode, action, mods)
    if key == glfwc.GLFW_KEY_ESCAPE and action == glfwc.GLFW_PRESS then
        window:setShouldClose(true)
    end
end)

window:makeContextCurrent()
glfw.swapInterval(1)

--
-- scene setup
--

local gl = require "gl_ffi.mod"
gl.load(glfw)

local engine = require "engine.mod"
local renderer = engine.Renderer.new()

local scene = require "scene.init"
local mesh = utils.new(scene.SceneMesh, {
    vertices = vertices,
    vertex_count = 3,
    vertex_stride = 20,
    shader = {
        vs = vs,
        fs = fs,
    },
})

local maf = require "mafex"
local clear_color = ffi.new("float[4]", 0.2, 0.3, 0.4, 1.0)

--
-- main loop
--
while not window:shouldClose(window) do
    -- update
    local width, height = window:getFramebufferSize()
    local m = maf.mat4.rotation_z(glfw.getTime() * 30)

    -- render
    renderer:clear(width, height, clear_color)
    renderer:render(mesh, {
        MVP = m.array,
    })
    window:swapBuffers()
    glfw.pollEvents()
end

glfw.terminate()
