local M = {}

---@param klass Table<string, any> metatable
---@param instance Table<string, any> instance
M.new = function(klass, instance)
    klass.__index = klass
    setmetatable(instance, klass)
    return instance
end

M.merge = function(src, dst)
    for k, v in pairs(src) do
        dst[k] = v
    end
end

return M
