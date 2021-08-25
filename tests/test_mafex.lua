local luaunit = require("luaunit")
package.path = package.path .. ";lua/?.lua"
local maf = require("mafex")

function testVec3()
    local a = maf.vec3(1, 2, 3)
    local b = maf.vec3(4, 5, 6)
    local c = a + b
    luaunit.assertEquals(c.x, 5)
end

-- function testFail()
--     luaunit.assertEquals({ 1, 2, 3 }, { 1, 2, 4 })
-- end

os.exit(luaunit.LuaUnit.run())
