local luaunit = require "luaunit"
package.path = package.path .. ";lua/?.lua"
local gltf = require "engine.gltf"
local sample_dir = os.getenv "GLTF_SAMPLE_MODELS"

function TestGltf()
    local path = sample_dir .. "/2.0/Cube/glTF/Cube.gltf"
    local loader = gltf.GltfLoader.from_path(path)
    luaunit.assertEquals(#loader.meshes, 1)
end

os.exit(luaunit.LuaUnit.run())
