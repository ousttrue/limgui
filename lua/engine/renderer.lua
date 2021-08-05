local ffi = require("ffi")
local utils = require("limgui.utils")
local M = {}
local gl = require("libs.gl_ffi.mod")
local shaders = require("engine.shaders")

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
    local shader = shaders.create(scene.shader_name)
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
