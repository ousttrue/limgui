local ffi = require("ffi")
local utils = require("limgui.utils")
local glfw = require("libs.gl_ffi.glfw")
local M = {}
local gl = require("libs.gl_ffi.mod")

local vertex_shader_text = [[#version 110
attribute vec2 vPos;
void main()
{
    gl_Position = vec4(vPos, 0.0, 1.0);
};
]]

local fragment_shader_text = [[#version 110
void main()
{
    gl_FragColor = vec4(1, 1, 1, 1);
};
]]

---@class VertexBuffer
---@field vbo any
---@field vertex_count number
M.VBO = {
    ---@param self VertexBuffer
    render = function(self)
        gl.glBindBuffer(gl.GL_ARRAY_BUFFER, self.vbo[0])
        gl.glDrawArrays(gl.GL_TRIANGLES, 0, self.vertex_count)
    end,
}

M.VBO.create = function(vertices, vertex_count)
    local vbo = ffi.new("GLuint[1]")
    gl.glGenBuffers(1, vbo)
    gl.glBindBuffer(gl.GL_ARRAY_BUFFER, vbo[0])
    gl.glBufferData(gl.GL_ARRAY_BUFFER, ffi.sizeof(vertices), vertices, gl.GL_STATIC_DRAW)
    return utils.new(M.VBO, {
        vbo = vbo,
        vertex_count = vertex_count,
    })
end

---@class Shader
---@field program any
---@field vpos any
M.Shader = {
    activate = function(self)
        -- set shader
        gl.glUseProgram(self.program)
        -- activate vertex slot
        gl.glEnableVertexAttribArray(self.vpos)
        -- FBO layout
        gl.glVertexAttribPointer(self.vpos, 2, gl.GL_FLOAT, gl.GL_FALSE, 8, nil)
    end,
}
M.Shader.create = function(vs, fs)
    local vertex_shader = gl.glCreateShader(gl.GL_VERTEX_SHADER)
    local pp = ffi.new("const char *[1]")
    pp[0] = vs
    gl.glShaderSource(vertex_shader, 1, pp, nil)
    gl.glCompileShader(vertex_shader)

    local fragment_shader = gl.glCreateShader(gl.GL_FRAGMENT_SHADER)
    pp[0] = fs
    gl.glShaderSource(fragment_shader, 1, pp, nil)
    gl.glCompileShader(fragment_shader)

    local program = gl.glCreateProgram()
    gl.glAttachShader(program, vertex_shader)
    gl.glAttachShader(program, fragment_shader)
    gl.glLinkProgram(program)

    local vpos_location = gl.glGetAttribLocation(program, "vPos")

    return utils.new(M.Shader, {
        program = program,
        vpos = vpos_location,
    })
end

---@class Drawable
---@field vbo VertexBuffer
---@field shader Shader
M.Drawable = {
    ---@param self Drawable
    render = function(self)
        self.shader:activate()
        self.vbo:render()
    end,
}
---@param scene Scene
---@return Drawable
M.Drawable.create = function(scene)
    local shader = M.Shader.create(vertex_shader_text, fragment_shader_text)
    local vbo = M.VBO.create(scene.vertices, scene.vertex_count)
    return utils.new(M.Drawable, {
        vbo = vbo,
        shader = shader,
    })
end

---@class Renderer
---@field drawable_map Table<Scene, Drawable>
M.Renderer = {
    ---@param self Renderer
    ---@param scene Scene
    ---@return Drawable
    get_or_create_drawable = function(self, scene)
        local drawable = self.drawable_map[scene]
        if not drawable then
            drawable = M.Drawable.create(scene)
            self.drawable_map[scene] = drawable
        end
        return drawable
    end,

    --- clear active RenderBuffer
    ---@param self Renderer
    ---@param w any
    ---@param h any
    ---@param clear_color table
    clear = function(self, w, h, clear_color)
        gl.load(glfw)
        gl.glViewport(0, 0, w, h)
        gl.glClearColor(
            clear_color[0] * clear_color[3],
            clear_color[1] * clear_color[3],
            clear_color[2] * clear_color[3],
            clear_color[3]
        )
        gl.glClear(gl.GL_COLOR_BUFFER_BIT)
    end,

    ---render scene
    ---@param self Renderer
    ---@param scene Scene
    render = function(self, scene)
        local drawable = self:get_or_create_drawable(scene)
        drawable:render()
    end,
}
M.Renderer.new = function()
    return utils.new(M.Renderer, {
        drawable_map = {},
    })
end

return M
