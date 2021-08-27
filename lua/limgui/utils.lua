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
        local content = file:read "*a"
        file:close()
        return content
    end
end

---@param path string
---@return string|table
M.dirname = function(path)
    local m = path:match "([^/\\]*)$"
    local dir = path:sub(1, #path - #m - 1)
    return dir
end

return M
