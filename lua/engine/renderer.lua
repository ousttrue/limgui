local utils = require "limgui.utils"
local M = {}
local gl = require "gl_ffi.mod"
local EngineDrawable = require "engine.drawable".EngineDrawable
local maf = require "mafex"


---@class EngineRenderer
---@field drawable_map Table<SceneMesh, EngineDrawable>
M.EngineRenderer = {
    ---@param self EngineRenderer
    ---@param mesh SceneMesh
    ---@return EngineDrawable
    get_or_create_drawable = function(self, mesh)
        local drawable = self.drawable_map[mesh]
        if not drawable then
            drawable = EngineDrawable.create(mesh)
            self.drawable_map[mesh] = drawable
        end
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
            for i, child in ipairs(node.children) do
                self:render_recursive(child, world, m, inv)
            end
        end
    end,
}
M.EngineRenderer.new = function()
    return utils.new(M.EngineRenderer, {
        drawable_map = {},
    })
end

return M
