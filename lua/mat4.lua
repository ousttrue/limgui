local ffi = require("ffi")
local M = {}

ffi.cdef[[
struct LuaMatrix4
{

};
]]

---@class Mat4
M.Mat4 = {
}
M.Mat4 = ffi.metatype('LuaMatrix4', M.Mat4)

return M
