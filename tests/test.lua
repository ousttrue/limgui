local luaunit = require("luaunit")

function TestPass()
    luaunit.assertEquals({ 1, 2, 3 }, { 1, 2, 3 })
end

-- function TestFail()
--     luaunit.assertEquals({ 1, 2, 3 }, { 1, 2, 4 })
-- end

os.exit(luaunit.LuaUnit.run())
