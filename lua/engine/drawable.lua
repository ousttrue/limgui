local utils = require "limgui.utils"
local VertexBuffer = require("engine.vertex_buffer").VertexBuffer

local M = {}

---@class EngineSubMesh
---@field index_draw_offset integer
---@field index_draw_count integer
---@field material SceneMaterial

---@class EngineDrawable
---@field vbo VertexBuffer
---@field submeshes EngineSubMesh[]
M.EngineDrawable = {
    ---@param self EngineDrawable
    ---@param variables any world and node level variable
    render = function(self, variables)
        for _, submesh in ipairs(self.submeshes) do
            submesh.material:activate(variables)
            self.vbo:render(submesh.index_draw_offset, submesh.index_draw_count)
        end
    end,
}

---@param mesh SceneMesh
---@param vertex_attributes VertexAttribute[]
---@return EngineDrawable
M.EngineDrawable.create = function(mesh, vertex_attributes)
    local vbo = VertexBuffer.create(
        mesh.vertices,
        mesh.vertex_count,
        mesh.vertex_stride,
        mesh.indices,
        mesh.index_count,
        mesh.index_stride,
        vertex_attributes
    )

    return utils.new(M.EngineDrawable, {
        vbo = vbo,
        submeshes = {},
    })
end

return M
