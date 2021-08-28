-- port from
--
-- * https://www.glfw.org/docs/latest/quick.html
--

local ffi = require "ffi"
local glfw = require "gl_ffi.glfw"
local glfwc = glfw.glfwc
local utils = require "limgui.utils"
local engine = require "engine.mod"
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

local camera = {
    mouse_left = false,
    mouse_middle = false,
    mouse_right = false,

    matrix = function(self)
        return self.view * self.projection
    end,

    --projection
    projection = maf.mat4.identity(),
    near = 0.01,
    far = 100,
    fovy_degree = 50,
    width = 640,
    height = 480,
    update_projection = function(self)
        self.projection = maf.mat4.perspective(self.fovy_degree, self.width / self.height, self.near, self.far)
    end,

    resize = function(self, w, h)
        self.width = w
        self.height = h
        self:update_projection()
    end,

    --view
    view = maf.mat4.identity(),
    shift = maf.vec3(0, 0, -5),
    yaw_degree = 0,
    pitch_degree = 0,
    update_view = function(self)
        self.view = maf.mat4.rotation_y(self.yaw_degree)
            * maf.mat4.rotation_x(self.pitch_degree)
            * maf.mat4.translation(self.shift)
    end,

    mouse_move = function(self, x, y)
        if self.x then
            local dx = x - self.x
            local dy = y - self.y
            if self.mouse_right then
                self.yaw_degree = self.yaw_degree + dx
                self.pitch_degree = self.pitch_degree - dy
                self:update_view()
            end
            if self.mouse_middle then
                local t = math.tan(self.fovy_degree * 0.5 * math.pi / 180)
                self.shift.x = self.shift.x - (dx / self.height) * t * self.shift.z * 2
                self.shift.y = self.shift.y + (dy / self.height) * t * self.shift.z * 2
                self:update_view()
            end
        end
        self.x = x
        self.y = y
    end,

    mouse_button = function(self, button, is_down)
        if button == 0 then
            self.mouse_left = is_down
        elseif button == 1 then
            self.mouse_right = is_down
        elseif button == 2 then
            self.mouse_middle = is_down
        end
    end,

    mouse_wheel = function(self, d)
        if d > 0 then
            self.shift.z = self.shift.z * 0.9
            self:update_view()
        elseif d < 0 then
            self.shift.z = self.shift.z * 1.1
            self:update_view()
        end
    end,
}
camera:update_projection()
camera:update_view()

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
local scene = utils.new(engine.Scene, {
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
    renderer:render(scene, {
        MVP = camera:matrix().array,
    })
    window:swapBuffers()
    glfw.pollEvents()
end
glfw.terminate()
