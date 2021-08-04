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

M.map = function(t, filter)
    local result = {}
    for k, v in pairs(t) do
        table.insert(result, filter(k, v))
    end
    return result
end

M.imap = function(t, filter)
    local result = {}
    for i, v in ipairs(t) do
        table.insert(result, filter(i, v))
    end
    return result
end

M.read_file = function(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if file then
        local content = file:read("*a") -- *a or *all reads the whole file
        file:close()
        return content
    end
end

return M
