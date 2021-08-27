local utils = require "limgui.utils"
local M = {}

---@class GltfLoader
M.GltfLoader = {}
M.GltfLoader.load = function(gltf)
    local instance = utils.new(M.GltfLoader, {
        meshes = {
            gltf = gltf,
        },
    })

    -- for i, mesh in ipairs(gltf.meshes) do
    --     for j, prim in ipairs(mesh.primitives) do
    --         local position_bytes = load_bytes(gltf, prim.attributes.POSITION)
    --     end
    -- end

    return instance
end

-- ---get accessor bytes
-- ---@param gltf table
-- ---@param accessor_index integer
-- local function load_bytes(gltf, accessor_index)
--     local accessor = gltf.accessors[accessor_index]
--     local bufferview
--     print(accessor)
-- end

return M
