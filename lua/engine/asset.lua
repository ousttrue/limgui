local M = {
    base = "assets",
}

-- TODO: watch file. uv_fs_event_start

local cache = {}

M.get = function(path)
    local asset = cache[path]
    if asset then
        return asset
    end

    local r = io.open(M.base .. "/" .. path, "rb")
    local src = r:read "*a"
    r:close()

    cache[path] = src
    return src
end

return M
