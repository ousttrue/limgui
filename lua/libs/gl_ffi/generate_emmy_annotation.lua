--- OpenGL, GLU, GLAD 部分の GL の EmmyAnnotation を生成する

local function table_find(t, pred)
    for i, v in ipairs(t) do
        if pred(i, v) then
            return v
        end
    end
end

---@param output string
---@param glad_header string
local function generate(output, glad_header)
    print(output, glad_header)

    local CommandLine = require("clangffi.commandline")
    local Parser = require("clangffi.parser")
    local clang_mod = require("clang.mod")
    local Exporter = require("clangffi.exporter")
    require("clangffi.cdef")
    local C = clang_mod.enums

    local cmd = CommandLine.parse({ string.format("-E%s,glad.dll", glad_header) })
    local parser = Parser.new()
    print("parse...")
    parser:parse(cmd.EXPORTS, cmd.CFLAGS)
    print(parser.node_count)

    print("remove_duplicated...")
    local count = parser.root:remove_duplicated()
    print(count)

    -- export
    print("export...")
    local count = 0
    local exporter = Exporter.new(parser.nodemap)
    local used = {}
    for _, node in parser.root:traverse() do
        if node.location and node.location.path:find("gl.h$") then
            used[node] = true
            count = count + 1

            if node.node_type == "typedef" and node.spelling:find("^PFN.*PROC$") then
                exporter:push(node)
            elseif node.node_type == "var" and node.spelling:find("^glad_") then
                exporter:push(node)
            elseif node.node_type == "define" and node.spelling:find("^GL_") then
                exporter:push(node)
            end
        end
    end
    exporter:execute()
    print(count)

    local header = (function()
        for header, export_header in pairs(exporter.map) do
            return export_header
        end
    end)()
    print(header)

    local cdef = ""
    local field = ""
    local field2 = ""
    local assign = ""
    for i, d in ipairs(header.defines) do
        cdef = cdef .. string.format("enum { %s = %s };\n", d.name, d.value)
        field2 = field2 .. string.format("M.%s = ffi.C.%s\n", d.name, d.name)
    end
    for i, t in ipairs(header.types) do
        cdef = cdef .. string.format("%s;\n", t:cdef())
    end
    for i, v in ipairs(header.variables) do
        local m = v.name:match("^glad_(.*)")
        local name = v.name:sub(6)
        if m then
            field = field .. string.format("---@field %s any\n", m)
            assign = assign
                .. string.format(
                    '    M.%s = ffi.cast(ffi.typeof("%s"), glfw.getProcAddress("%s"))\n',
                    name,
                    v.type.name,
                    name
                )
        end
    end

    print(string.format("write: %s...", output))
    local w = io.open(output, "wb")
    w:write(string.format(
        [=[-- this is generated
local ffi = require("ffi")
ffi.cdef[[
%s    
]]

---@class OpenGL
%s
local M = {}
%s

local is_loaded = false
M.load = function(glfw)
    if is_loaded then
        return
    end
    is_loaded = true
    
%s

end

return M
]=],
        cdef,
        field,
        field2,
        assign
    ))
    w:close()

    print("done.")
end

generate(...)
