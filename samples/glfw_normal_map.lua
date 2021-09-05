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
layout(location = 0) in vec3 VertexPosition;
layout(location = 1) in vec3 VertexNormal;
layout(location = 2) in vec2 VertexTexCoord;
layout(location = 3) in vec4 VertexTangent;
uniform mat4 MVP;
out vec3 Color;

void main()
{
    gl_Position = MVP * vec4(VertexPosition, 1.0);
    Color = vec3(VertexTangent);
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

--
-- glfw setup
--

glfw.setErrorCallback(function(error, description)
    print(string.format("Error: %s\n", description))
end)
if glfw.init() == 0 then
    assert(false)
end
local window = glfw.Window:__new(400, 400, "MouseCamera", nil, nil)
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
camera.shift.z = -3
camera.yaw_degree = -40
camera:update_view()

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
local path = os.getenv "GLTF_SAMPLE_MODELS" .. "/2.0/DamagedHelmet/glTF-Binary/DamagedHelmet.glb"
local loader = scene.GltfLoader.from_path(path)
for _, m in ipairs(loader.meshes) do
    for _, submesh in ipairs(m.submeshes) do
        submesh.material.shader = {
            vs = vs,
            fs = fs            
        }
    end
end

local clear_color = ffi.new("float[4]", 0.2, 0.3, 0.4, 1.0)
local world = scene.World.new()
world.LightDirection = maf.vec3(-1, -1, -1):normalize()

--
-- main loop
--
local renderer = engine.Renderer.new()
while not window:shouldClose(window) do
    -- update
    local width, height = window:getFramebufferSize()
    world.Projection = camera.projection
    world.View = camera.view
    -- render
    renderer:clear(width, height, clear_color)
    renderer:render_recursive(loader.root, world)
    window:swapBuffers()
    glfw.pollEvents()
end
glfw.terminate()
