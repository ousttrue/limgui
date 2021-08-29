local luaunit = require "luaunit"

function TestPass()
    luaunit.assertEquals({ 1, 2, 3 }, { 1, 2, 3 })
end

function TestZero()
    local zero = "a\0b"
    luaunit.assertEquals(#zero, 3)

    local some = "123"
    luaunit.assertEquals(some:sub(1, 2), "12")
end

-- function TestFail()
--     luaunit.assertEquals({ 1, 2, 3 }, { 1, 2, 4 })
-- end

os.exit(luaunit.LuaUnit.run())
