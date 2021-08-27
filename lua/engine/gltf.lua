local utils = require "limgui.utils"
local json = require "libs.json"

local M = {}

--
-- caution !! lua is 1 origin, but gltf all index is 0 origin.
--

---@class GltfLoader
M.GltfLoader = {
    load = function(self)
        for i, mesh in ipairs(self.gltf.meshes) do
            for j, prim in ipairs(mesh.primitives) do
                local position_bytes = self:load_bytes(prim.attributes.POSITION)
            end
        end
    end,

    uri_to_path = function(self, uri)
        return utils.dirname(self.path) .. "/" .. uri
    end,

    ---get bytes from uri. uri_map is cache
    ---@param self any
    ---@param uri string
    uri_bytes = function(self, uri)
        local bytes = self.uri_map[uri]
        if bytes then
            return bytes
        end

        local path = self:uri_to_path(uri)
        local r = io.open(path, "rb")
        bytes = r:read "*a"
        r:close()
        self.uri_map[uri] = bytes
        return bytes
    end,

    ---get accessor bytes
    ---@param accessor_index integer
    load_bytes = function(self, accessor_index)
        local accessor = self.gltf.accessors[accessor_index + 1]
        local bufferView = self.gltf.bufferViews[accessor.bufferView + 1]
        local buffer = self.gltf.buffers[bufferView.buffer + 1]
        local buffer_bytes = self:uri_bytes(buffer.uri)
        local sub_bytes = buffer_bytes:sub(bufferView.byteOffset + 1, bufferView.byteOffset + 1 + bufferView.byteLength)
        local a = 0
    end,
}

---load GLTF
---@param path string glTF file path
---@return table<string, any>
M.GltfLoader.from_path = function(path)
    local r = io.open(path, "rb")
    local src = r:read "*a"
    r:close()
    local gltf = json.decode(src)

    local instance = utils.new(M.GltfLoader, {
        path = path,
        uri_map = {},
        gltf = gltf,
        meshes = {},
    })

    instance:load()

    return instance
end

return M
