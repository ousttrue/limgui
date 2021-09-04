local utils = require "limgui.utils"
local M = {}
local gl = require "gl_ffi.mod"
local shader_module = require "engine.shader"
local VertexBuffer = require("engine.vertex_buffer").VertexBuffer
local maf = require "mafex"

---@class SubMesh
---@field index_draw_offset integer
---@field index_draw_count integer
---@field material SceneMaterial
---@field shader Shader

---@class Drawable
---@field vbo VertexBuffer
---@field submeshes SubMesh[]
M.Drawable = {
    ---@param self Drawable
    ---@param variables any world and node level variable
    render = function(self, variables)
        for _, submesh in ipairs(self.submeshes) do
            submesh.shader:activate(variables, submesh.material)
            self.vbo:render(submesh.index_draw_offset, submesh.index_draw_count)
        end
    end,
}

---@param mesh SceneMesh
---@return Drawable
M.Drawable.create = function(mesh)
    if not mesh.submeshes then
        mesh.submeshes = {
            {
                shader = mesh.shader,
                index_draw_offset = 0,
                index_draw_count = mesh.index_count,
            },
        }
    end

    -- submesh
    for _, submesh in ipairs(mesh.submeshes) do
        submesh.shader = shader_module.create(submesh.shader)
    end

    local vbo = VertexBuffer.create(
        mesh.vertices,
        mesh.vertex_count,
        mesh.vertex_stride,
        mesh.indices,
        mesh.index_count,
        mesh.index_stride,
        mesh.submeshes[1].shader.vertex_attributes
    )

    return utils.new(M.Drawable, {
        vbo = vbo,
        submeshes = mesh.submeshes,
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
    ---@param world SceneWorld
    ---@param parent mat4
    ---@param parent_inverse mat3
    render_recursive = function(self, node, world, parent, parent_inverse)
        parent = parent or maf.mat4.identity()
        local m = node:matrix() * parent

        parent_inverse = parent_inverse or maf.mat3.identity()
        local inv = parent_inverse * node:inverse_matrix()

        if node.mesh then
            self:render(node.mesh, {
                MVP = m * world.View * world.Projection,
                NormalMatrix = inv:transpose(),
                LightDirection = world.LightDirection,
            })
        end

        if node.children then
            for i, child in ipairs(node.children) do
                self:render_recursive(child, world, m, inv)
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
