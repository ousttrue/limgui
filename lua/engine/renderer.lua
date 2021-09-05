local utils = require "limgui.utils"
local M = {}
local gl = require "gl_ffi.mod"
local EngineDrawable = require("engine.drawable").EngineDrawable
local EngineMaterial = require("engine.material").EngineMaterial
local EngineTexture = require("engine.material").EngineTexture
local shader_module = require "engine.shader"
local maf = require "mafex"

---@class EngineRenderer
---@field texture_map table<SceneTexture, EngineTexture>
---@field material_map table<SceneMaterial, EngineMaterial>
---@field drawable_map table<SceneMesh, EngineDrawable>
M.EngineRenderer = {
    ---comment
    ---@param self EngineRenderer
    ---@param src SceneTexture
    ---@return EngineTexture
    get_or_create_texture = function(self, src)
        local texture = self.texture_map[src]
        if texture then
            return texture
        end

        texture = EngineTexture.load(src)
        self.texture_map[src] = texture
        return texture
    end,

    ---comment
    ---@param self EngineRenderer
    ---@param src SceneMaterial
    ---@return EngineMaterial
    get_or_create_material = function(self, src)
        local material = self.material_map[src]
        if material then
            return material
        end

        local shader = shader_module.create(src.shader)
        material = EngineMaterial.new(shader)
        if src.base_texture then
            local texture = self:get_or_create_texture(src.base_texture)
            material.base_texture = texture
        end
        self.material_map[src] = material
        return material
    end,

    ---@param self EngineRenderer
    ---@param src SceneMesh
    ---@return EngineDrawable
    get_or_create_drawable = function(self, src)
        local drawable = self.drawable_map[src]
        if drawable then
            return drawable
        end

        -- submesh
        if not src.submeshes then
            src.submeshes = {
                {
                    material = {
                        shader = src.shader,
                    },
                    index_draw_offset = 0,
                    index_draw_count = src.index_count,
                },
            }
        end

        local submeshes = {}
        for _, submesh in ipairs(src.submeshes) do
            table.insert(submeshes, {
                index_draw_offset = submesh.index_draw_offset,
                index_draw_count = submesh.index_draw_count,
                material = self:get_or_create_material(submesh.material),
            })
        end

        drawable = EngineDrawable.create(src, submeshes[1].material.shader.vertex_attributes)
        drawable.submeshes = submeshes
        self.drawable_map[src] = drawable
        return drawable
    end,

    --- clear active RenderBuffer
    ---@param self EngineRenderer
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
    ---@param self EngineRenderer
    ---@param mesh SceneMesh
    render = function(self, mesh, variables)
        local drawable = self:get_or_create_drawable(mesh)
        drawable:render(variables or {})
    end,

    ---comment
    ---@param self EngineRenderer
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
            for _, child in ipairs(node.children) do
                self:render_recursive(child, world, m, inv)
            end
        end
    end,
}
M.EngineRenderer.new = function()
    return utils.new(M.EngineRenderer, {
        texture_map = {},
        material_map = {},
        drawable_map = {},
    })
end

return M
