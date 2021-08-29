local luaunit = require "luaunit"
package.path = package.path .. ";lua/?.lua"
local engine = require "engine.mod"

function TestCamera()
    local camera = engine.OrbitCamera.new()
    local m = camera:matrix()
    luaunit.assertEquals(type(m), "cdata")
end

os.exit(luaunit.LuaUnit.run())
