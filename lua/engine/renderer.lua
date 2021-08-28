local utils = require "limgui.utils"
local M = {}
local gl = require "gl_ffi.mod"
local shaders = require "engine.shaders"
local VBO = require("engine.vbo").VBO

---@class Drawable
---@field vbo VertexBuffer
---@field shader Shader
M.Drawable = {
    ---@param self Drawable
    render = function(self, variables)
        self.shader:activate(variables)
        self.vbo:render()
    end,
}
---@param scene Scene
---@return Drawable
M.Drawable.create = function(scene)
    local shader = shaders.create(scene.shader_name)
    local vbo = VBO.create(scene.vertices, scene.vertex_count)
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
    render = function(self, scene, variables)
        local drawable = self:get_or_create_drawable(scene)
        drawable:render(variables or {})
    end,
}
M.Renderer.new = function()
    return utils.new(M.Renderer, {
        drawable_map = {},
    })
end

return M
