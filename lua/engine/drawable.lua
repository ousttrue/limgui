local utils = require "limgui.utils"
local shader_module = require "engine.shader"
local VertexBuffer = require("engine.vertex_buffer").VertexBuffer

local M = {}

---@class EngineSubMesh
---@field index_draw_offset integer
---@field index_draw_count integer
---@field material SceneMaterial
---@field shader Shader

---@class EngineDrawable
---@field vbo VertexBuffer
---@field submeshes EngineSubMesh[]
M.EngineDrawable = {
    ---@param self EngineDrawable
    ---@param variables any world and node level variable
    render = function(self, variables)
        for _, submesh in ipairs(self.submeshes) do
            submesh.shader:activate(variables, submesh.material)
            self.vbo:render(submesh.index_draw_offset, submesh.index_draw_count)
        end
    end,
}

---@param mesh SceneMesh
---@return EngineDrawable
M.EngineDrawable.create = function(mesh)
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

    return utils.new(M.EngineDrawable, {
        vbo = vbo,
        submeshes = mesh.submeshes,
    })
end

return M
