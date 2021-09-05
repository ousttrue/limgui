local utils = require "limgui.utils"
local json = require "json"
local ffi = require "ffi"
local maf = require "mafex"
local SceneMesh = require("scene.mesh").SceneMesh
local SceneNode = require("scene.node").SceneNode
local SceneMaterial = require("scene.material").SceneMaterial
local SceneTexture = require("scene.material").SceneTexture

-- assets/gltf.vs
ffi.cdef [[
typedef struct {
    vec3 POSITION;
    vec3 NORMAL;
    vec2 TEXCOORD_0;
    vec4 TANGENT;
} vertex;
]]

---@class Slice
---@field slice ffi.cdata* pointer to T
---@field count integer count of T

--
-- https://github.com/KhronosGroup/glTF/tree/master/specification/2.0/schema
--
local M = {}

---@class GltfBuffer
---@field uri string

---@class GltfBufferView
---@field buffer integer
---@field byteOffset integer
---@field byteLength integer

---@class GltfAccessor
---@field bufferView integer
---@field byteOffset integer
---@field type string ["SCALAR", "VEC2", "VEC3", "VEC4", "MAT2", "MAT3", "MAT4"]
---@field componentType integer [5120:BYTE, 5121:UBYTE, 5122:SHORT, 5123:USHORT, 5125:UINT, 5126:FLOAT]
---@field count integer

---comment
---@param accessor GltfAccessor
---@return string cdef in mafex
local function accessor_type(accessor)
    if accessor.componentType == 5126 then
        if accessor.type == "VEC2" then
            return "vec2"
        elseif accessor.type == "VEC3" then
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

---@class GltfAttributes
---@field POSITION integer
---@field NORMAL integer
---@field TEXCOORD_0 integer
---@field TEXCOORD_1 integer
---@field TANGENT integer
---@field COLOR_0 integer
---@field JOINTS_0 integer
---@field WEIGHTS_0 integer

---@class GltfPrimitive
---@field attributes GltfAttributes
---@field indices integer
---@field material integer

---@class GltfMesh
---@field primitives GltfPrimitive[]

---@class GltfNode
---@field name string
---@field children integer[]
---@field matrix number[]
---@field rotation number[]
---@field scale number[]
---@field translation number[]
---@field mesh integer
---@field skin integer

---@class GltfTextureInfo
---@field index integer

---@class GltfPbrMetallicRoughness
---@field baseColorFactor number[]
---@field baseColorTexture GltfTextureInfo
---@field metallicFactor number
---@field roughnessFactor number
---@field metallicRoughnessTexture GltfTextureInfo

---@class GltfMaterial
---@field name string
---@field pbrMetallicRoughness GltfPbrMetallicRoughness
---@field normalTexture GltfTextureInfo
---@field occlusionTexture GltfTextureInfo
---@field emissiveTexture GltfTextureInfo
---@field emissiveFactor number[]
---@field alphaMode string ["OPAQUE", "MASK", "BLEND"]
---@field alphaCutoff number
---@field doubleSided boolean

---@class GltfSampler
---@field magFilter integer [9728:NEAREST, 9729:LINEAR]
---@field minFilter integer [9728:NEAREST, 9729:LINEAR, 9984:NEAREST_MIPMAP_NEAREST, 9985:LINEAR_MIPMAP_NEAREST, 9986:NEAREST_MIPMAP_LINEAR, 9987:LINEAR_MIPMAP_LINEAR]
---@field wrapS integer [33071:CLAMP_TO_EDGE, 33648:MIRRORED_REPEAT, 10497:REPEAT]
---@field wrapT integer [33071:CLAMP_TO_EDGE, 33648:MIRRORED_REPEAT, 10497:REPEAT]

---@class GltfImage
---@field name string
---@field uri string
---@field mimeType string
---@field bufferView integer

---@class GltfTexture
---@field name string
---@field sampler integer
---@field source integer

---@class Gltf
---@field buffers GltfBuffer[]
---@field bufferViews GltfBufferView[]
---@field accessors GltfAccessor[]
---@field meshes GltfMesh[]
---@field nodes GltfNode[]
---@field materials GltfMaterial[]
---@field textures GltfTexture[]
---@field samplers GltfSampler[]
---@field images GltfImage[]

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
---@field images Slice[]
---@field textures SceneTexture[]
---@field materials SceneMaterial[]
---@field meshes SceneMesh[]
---@field nodes SceneNode[]
---@field root SceneNode
M.GltfLoader = {
    ---comment
    ---@param self GltfLoader
    load = function(self)
        self.uri_map = {}

        self.images = {}
        for _, image in ipairs(self.gltf.images) do
            local scene_image = self:load_image(image)
            table.insert(self.images, scene_image)
        end

        -- textures
        self.textures = {}
        for _, texture in ipairs(self.gltf.textures) do
            local scene_texture = self:load_texture(texture)
            table.insert(self.textures, scene_texture)
        end

        -- materials
        self.materials = {}
        for _, material in ipairs(self.gltf.materials) do
            local scene_material = self:load_material(material)
            table.insert(self.materials, scene_material)
        end

        -- mesh
        self.meshes = {}
        for _, mesh in ipairs(self.gltf.meshes) do
            local scene_mesh = self:load_mesh(mesh)
            table.insert(self.meshes, scene_mesh)
        end

        -- node
        self.nodes = {}
        for _, node in ipairs(self.gltf.nodes) do
            local scene_node = SceneNode.new(node.name)
            if node.matrix then
                scene_node.transform.matrix = maf.mat4(node.matrix)
            else
                scene_node.transform.t = maf.vec3(node.translation or { 0, 0, 0 })
                scene_node.transform.r = maf.quat(node.rotation or { 0, 0, 0, 1 })
                scene_node.transform.s = maf.vec3(node.scale or { 1, 1, 1 })
            end
            if node.mesh then
                scene_node.mesh = self.meshes[node.mesh + 1]
            end
            table.insert(self.nodes, scene_node)
        end

        for i, node in ipairs(self.gltf.nodes) do
            if node.children then
                for _, child in ipairs(node.children) do
                    self.nodes[i]:add_child(self.nodes[child + 1])
                end
            end
        end

        for _, node in ipairs(self.nodes) do
            if not node.parent then
                assert(not self.root)
                self.root = node
            end
        end
    end,

    ---comment
    ---@param self GltfLoader
    ---@param image GltfImage
    ---@return Slice
    load_image = function(self, image)
        local bufferBytes
        local offset = 0
        local length = 0
        if image.uri then
            bufferBytes = self:uri_bytes(image.uri)
            length = ffi.sizeof(bufferBytes)
        else
            local bufferView = self.gltf.bufferViews[image.bufferView + 1]
            local buffer = self.gltf.buffers[bufferView.buffer + 1]
            if buffer.uri then
                assert(false)
            else
                bufferBytes = self.bin
            end
            offset = (bufferView.byteOffset or 0)
            length = bufferView.byteLength
        end
        local slice = ffi.cast("uint8_t*", bufferBytes + offset)
        return { slice = slice, count = length }
    end,

    ---comment
    ---@param self GltfLoader
    ---@param texture GltfTexture
    ---@return SceneTexture
    load_texture = function(self, texture)
        local image = self.images[texture.source + 1]
        local gltf_image = self.gltf.images[texture.source + 1]
        return SceneTexture.new(texture.name or gltf_image.name, image)
    end,

    ---comment
    ---@param self GltfLoader
    ---@param material GltfMaterial
    ---@return SceneMaterial
    load_material = function(self, material)
        local scene_material = SceneMaterial.new(material.name)
        scene_material.shader = "GLTF"
        if material.pbrMetallicRoughness then
            if material.pbrMetallicRoughness.baseColorFactor then
                scene_material.base_color = maf.vec4(material.pbrMetallicRoughness.baseColorFactor)
            end
            if material.pbrMetallicRoughness.baseColorTexture then
                local texture = self.textures[material.pbrMetallicRoughness.baseColorTexture.index + 1]
                scene_material.base_texture = texture
            end
        end
        return scene_material
    end,

    ---comment
    ---@param self GltfLoader
    ---@param mesh GltfMesh
    ---@return SceneMesh
    load_mesh = function(self, mesh)
        local buffers = {}
        local vertex_count = 0
        local index_count = 0
        local submeshes = {}
        for _, prim in ipairs(mesh.primitives) do
            -- vertex
            local buffer = {
                indices = self:typed_slice(prim.indices),
                POSITION = self:typed_slice(prim.attributes.POSITION),
                NORMAL = self:typed_slice(prim.attributes.NORMAL),
                TEXCOORD_0 = self:typed_slice(prim.attributes.TEXCOORD_0),
                TEXCOORD_1 = self:typed_slice(prim.attributes.TEXCOORD_1),
                TANGENT = self:typed_slice(prim.attributes.TANGENT),
            }
            table.insert(buffers, buffer)

            -- submesh
            local material = self.materials[prim.material + 1]
            table.insert(submeshes, {
                material = material,
                index_draw_count = buffer.indices.count,
                index_draw_offset = index_count,
            })

            vertex_count = vertex_count + buffer.POSITION.count
            index_count = index_count + buffer.indices.count
        end

        -- concat vertex buffer
        local vertices = ffi.new("vertex[?]", vertex_count)
        local vertex_stride = ffi.sizeof "vertex"
        local indices = ffi.new("uint32_t[?]", index_count)
        local index_stride = ffi.sizeof "uint32_t"
        local vertex_offset = 0
        local index_offset = 0
        for _, buffer in ipairs(buffers) do
            for k, v in pairs(buffer) do
                if k == "indices" then
                    local slice = v.slice
                    for j = 0, v.count - 1 do
                        indices[index_offset + j] = vertex_offset + slice[j]
                    end
                else
                    assert(v.count == buffer.POSITION.count)
                    local slice = v.slice
                    for j = 0, v.count - 1 do
                        vertices[vertex_offset + j][k] = slice[j]
                    end
                end
            end

            vertex_offset = vertex_offset + buffer.POSITION.count
            index_offset = index_offset + buffer.indices.count
        end

        local scene_mesh = SceneMesh.new(
            vertices,
            vertex_count,
            vertex_stride,
            indices,
            index_count,
            index_stride,
            nil,
            submeshes
        )

        return scene_mesh
    end,

    ---get accessor bytes
    ---@param accessor_index integer
    ---@return Slice
    typed_slice = function(self, accessor_index)
        if not accessor_index then
            return
        end

        local accessor = self.gltf.accessors[accessor_index + 1]
        local bufferView = self.gltf.bufferViews[accessor.bufferView + 1]
        local buffer = self.gltf.buffers[bufferView.buffer + 1]
        local bufferBytes
        if buffer.uri then
            bufferBytes = self:uri_bytes(buffer.uri)
        else
            bufferBytes = self.bin
        end
        local offset = (bufferView.byteOffset or 0) + (accessor.byteOoffset or 0)
        local maf_type = accessor_type(accessor)

        local slice = ffi.cast(maf_type .. "*", bufferBytes + offset)
        return {
            slice = slice,
            count = accessor.count,
        }
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
            assert(false)
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
}

---load GLTF
---@param path string glTF file path
---@return GltfLoader
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
    })

    instance:load()

    return instance
end

return M
