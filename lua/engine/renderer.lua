local utils = require "limgui.utils"
local M = {}
local gl = require "gl_ffi.mod"
local shader = require "engine.shader"
local VertexBuffer = require("engine.vertex_buffer").VertexBuffer
local maf = require "mafex"

---@class Drawable
---@field vbo VertexBuffer
---@field shader Shader
M.Drawable = {
    ---@param self Drawable
    render = function(self, variables)
        self.shader:activate(variables)
        self.vbo:render(self.shader.vertex_attributes)
    end,
}
---@param mesh SceneMesh
---@return Drawable
M.Drawable.create = function(mesh)
    local shader = shader.create(mesh.shader)
    local vbo = VertexBuffer.create(
        mesh.vertices,
        mesh.vertex_count,
        mesh.vertex_stride,
        mesh.indices,
        mesh.index_count,
        mesh.index_stride
    )
    return utils.new(M.Drawable, {
        vbo = vbo,
        shader = shader,
    })
end

---@class Renderer
---@field drawable_map Table<SceneMesh, Drawable>
M.Renderer = {
    ---@param self Renderer
    ---@param mesh SceneMesh
    ---@return Drawable
    get_or_create_drawable = function(self, mesh)
        local drawable = self.drawable_map[mesh]
        if not drawable then
            drawable = M.Drawable.create(mesh)
            self.drawable_map[mesh] = drawable
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
        gl.glClear(bit.bor(gl.GL_COLOR_BUFFER_BIT, gl.GL_DEPTH_BUFFER_BIT))
    end,

    ---render scene
    ---@param self Renderer
    ---@param mesh SceneMesh
    render = function(self, mesh, variables)
        local drawable = self:get_or_create_drawable(mesh)
        drawable:render(variables or {})
    end,

    ---comment
    ---@param self Renderer
    ---@param node SceneNode
    ---@param m mat4
    render_recursive = function(self, node, m, v, p)
        m = m or maf.mat4.identity()
        if node.mesh then
            self:render(node.mesh, {
                MVP = m * v * p,
            })
        end

        if node.children then
            for i, child in ipairs(node.children) do
                self:render_recursive(child, child:local_matrix() * m, v, p)
            end
        end
    end,
}
M.Renderer.new = function()
    return utils.new(M.Renderer, {
        drawable_map = {},
    })
end

return M
