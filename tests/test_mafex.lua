local luaunit = require("luaunit")
package.path = package.path .. ";lua/?.lua"
local maf = require("mafex")

function TestVec3()
    local a = maf.vec3(1, 2, 3)
    local b = maf.vec3(4, 5, 6)
    local c = a + b
    luaunit.assertEquals(c.x, 5)
end

function TestMat4()
    local m = maf.mat4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    luaunit.assertEquals(m._21, 5)
    luaunit.assertEquals(m._33, 0)

    local i = maf.mat4.identity()
    luaunit.assertEquals(i._11, 1)
end

os.exit(luaunit.LuaUnit.run())
