local utils = require "limgui.utils"
local json = require "libs.json"
local ffi = require "ffi"
local maf = require "mafex"

local M = {}

---@class Buffer
---@field uri string

---@class BufferView
---@field byteOffset integer
---@field byteLength integer

---@class Accessor
---@field bufferView integer
---@field byteOffset integer
---@field type string ["SCALAR", "VEC2", "VEC3", "VEC4", "MAT2", "MAT3", "MAT4"]
---@field componentType integer [5120:BYTE, 5121:UBYTE, 5122:SHORT, 5123:USHORT, 5125:UINT, 5126:FLOAT]
---@field count integer

---comment
---@param accessor Accessor
---@return string cdef in mafex
local function accessor_type(accessor)
    if accessor.componentType == 5126 then
        if accessor.type == "VEC3" then
            return "vec3"
        else
            error "not implemented"
        end
    elseif accessor.componentType == 5123 then
        if accessor.type == "SCALAR" then
            return "uint16_t"
        else
            error "not implemented"
        end
    else
        error "not implemented"
    end
end

---@class Attributes
---@field POSITION integer

---@class Primitive
---@field attributes Attributes
---@field indices integer
---@field material integer

---@class Mesh
---@field primitives Primitive[]

---@class Gltf
---@field buffers Buffer[]
---@field bufferViews BufferView[]
---@field accessors Accessor[]
---@field meshes Mesh[]

--
-- caution !! lua is 1 origin, but gltf all index is 0 origin.
--

---@class GltfLoader
---@field gltf Gltf
---@field uri_map table<string, ffi.cdata*>
M.GltfLoader = {
    ---comment
    ---@param self GltfLoader
    load = function(self)
        for i, mesh in ipairs(self.gltf.meshes) do
            local prims = {}
            for j, prim in ipairs(mesh.primitives) do
                table.insert(prims, {
                    position = {self:load_bytes(prim.attributes.POSITION)},
                    indices = {self:load_bytes(prim.indices)},
                })
            end
            local a = 0
        end
    end,

    uri_to_path = function(self, uri)
        return utils.dirname(self.path) .. "/" .. uri
    end,

    ---get bytes from uri. uri_map is cache
    ---@param self GltfLoader
    ---@param uri string
    ---@return ffi.cdata*
    uri_bytes = function(self, uri)
        local bytes = self.uri_map[uri]
        if bytes then
            return bytes
        end

        local path = self:uri_to_path(uri)
        local r = io.open(path, "rb")
        bytes = r:read "*a"

        bytes = ffi.new("uint8_t[?]", #bytes, bytes)

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
        local offset = (bufferView.byteOffset or 0) + (accessor.byteOoffset or 0)
        local maf_type = accessor_type(accessor)

        local slice = ffi.cast(maf_type .. "*", buffer_bytes + offset)
        return slice, accessor.count
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
