local utils = require "limgui.utils"
local json = require "json"
local ffi = require "ffi"
local maf = require "mafex"

-- assets/gltf.vs
ffi.cdef [[
typedef struct {
    vec3 position;
    vec3 normal;
} vertex;
]]

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
---@field NORMAL integer

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

---@class Vertices

---componentType integer [5120:BYTE, 5121:UBYTE, 5122:SHORT, 5123:USHORT, 5125:UINT, 5126:FLOAT]
local componentTypeMap = {
    [5120] = 1,
    [5121] = 1,
    [5122] = 2,
    [5123] = 2,
    [5125] = 4,
}

---@class GltfLoader
---@field gltf Gltf
---@field bin ffi.cdata* glb chunk
---@field uri_map table<string, ffi.cdata*>
---@field meshes Vertices[]
M.GltfLoader = {
    ---comment
    ---@param self GltfLoader
    load = function(self)
        for i, mesh in ipairs(self.gltf.meshes) do
            local buffers = {}
            local vertex_count = 0
            local index_count = 0
            -- local index_stride = componentTypeMap[self.gltf.accessors[mesh.primitives[1].indices + 1].componentType]
            for j, prim in ipairs(mesh.primitives) do
                local buffer = {
                    position = self:typed_slice(prim.attributes.POSITION),
                    normal = self:typed_slice(prim.attributes.NORMAL),
                    indices = self:typed_slice(prim.indices),
                }
                vertex_count = vertex_count + buffer.position.count
                index_count = index_count + buffer.indices.count
                table.insert(buffers, buffer)
            end

            local vertices = ffi.new("vertex[?]", vertex_count)
            local indices = ffi.new("uint32_t[?]", index_count)

            local vertex_offset = 0
            local index_offset = 0
            for i, buffer in ipairs(buffers) do
                -- position
                do
                    local slice = buffer.position.slice
                    for j = 0, buffer.position.count - 1 do
                        vertices[vertex_offset + j].position = slice[j]
                    end
                end
                if buffer.normal then
                    assert(buffer.position.count == buffer.normal.count)
                    local slice = buffer.normal.slice
                    for j = 0, buffer.normal.count - 1 do
                        vertices[vertex_offset + j].normal = slice[j]
                    end
                end
                -- indices
                do
                    local slice = buffer.indices.slice
                    for j = 0, buffer.indices.count - 1 do
                        indices[index_offset + j] = vertex_offset + slice[j]
                    end
                end
                vertex_offset = vertex_offset + buffer.position.count
                index_offset = index_offset + buffer.indices.count
            end

            table.insert(self.meshes, {
                vertices = vertices,
                vertex_count = vertex_count,
                vertex_stride = 20,
                indices = indices,
                index_count = index_count,
                index_stride = 4,
                shader = "GLTF",
            })
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
        if not uri then
            -- return glb chunk
            return self.bin
        end

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
    typed_slice = function(self, accessor_index)
        if not accessor_index then
            return
        end

        local accessor = self.gltf.accessors[accessor_index + 1]
        local bufferView = self.gltf.bufferViews[accessor.bufferView + 1]
        local buffer = self.gltf.buffers[bufferView.buffer + 1]
        local buffer_bytes = self:uri_bytes(buffer.uri)
        local offset = (bufferView.byteOffset or 0) + (accessor.byteOoffset or 0)
        local maf_type = accessor_type(accessor)

        local slice = ffi.cast(maf_type .. "*", buffer_bytes + offset)
        return {
            slice = slice,
            count = accessor.count,
        }
    end,
}

---load GLTF
---@param path string glTF file path
---@return table<string, any>
M.GltfLoader.from_path = function(path)
    local r = io.open(path, "rb")
    local src = r:read "*a"
    r:close()

    local gltf, bin
    if src:sub(1, 4) == "glTF" then
        local p = ffi.cast("uint8_t*", src)
        local version = ffi.cast("uint32_t*", p + 4)[0]
        assert(version == 2)
        local len = ffi.cast("uint32_t*", p + 8)[0]
        -- print(version, len)
        local pos = 12
        while pos < len do
            local chunk_length = ffi.cast("uint32_t*", p + pos)[0]
            pos = pos + 4
            local chunk_type = src:sub(pos + 1, pos + 4)
            pos = pos + 4
            local chunk_data = src:sub(pos + 1, pos + chunk_length - 1)
            pos = pos + chunk_length
            if chunk_type == "JSON" then
                gltf = chunk_data
            elseif chunk_type == "BIN\0" then
                bin = ffi.new("uint8_t[?]", chunk_length, chunk_data)
            else
                -- skip
            end
        end
    else
        -- as gltf
        gltf = src
    end

    local instance = utils.new(M.GltfLoader, {
        path = path,
        gltf = json.decode(gltf),
        bin = bin,
        uri_map = {},
        meshes = {},
    })

    instance:load()

    return instance
end

return M
