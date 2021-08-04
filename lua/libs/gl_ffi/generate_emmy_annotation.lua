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
    local C = clang_mod.enums

    local cmd = CommandLine.parse({ string.format("-E%s,glad.dll", glad_header) })
    local parser = Parser.new()
    print("parse...")
    parser:parse(cmd.EXPORTS, cmd.CFLAGS)
    print(parser.node_count)

    print("remove_duplicated...")
    local count = parser.root:remove_duplicated()
    print(count)

    local root = table_find(parser.root.children, function(i, v)
        return v.cursor_kind == C.CXCursorKind.CXCursor_FirstDecl
    end)
    -- print(root)

    local kv = ""
    for i, node in ipairs(root.children) do
        if node.spelling:find("^glad_") then
            print(node)
            local name = node.spelling:sub(6)
            local proc_type = name
            kv = kv .. string.format("    load_proc('PFN%sPROC', '%s')\n", proc_type:upper(), name)
        end
    end

    print(string.format("write: %s...", output))
    local w = io.open(output, "wb")
    w:write(string.format(
        [[-- this is generated

local gllib = require("libs.gl_ffi.gl")

---@class OpenGL
local M = {}

---@param proc_type string PFN_XXX_PROC
---@param name string symbol_name
local function load_proc(proc_type, name)
    local ffi = require("ffi")
    local ok, typ = pcall(ffi.typeof, proc_type)
    if not ok then
        error("Couldn't find pointer type for " .. proc_type .. " (are you accessing the right function?)", 2)
    end

    local ptr = ffi.cast(typ, glfw.glfwGetProcAddress(name))
    if ptr == nil then
        error("Unable to load function: " .. name, 2)
    end

    M[name] = ptr
end

M.load = function(glfw)
    gllib.set_loader(glfw)

    -- glc
    for k, v in pairs(gllib.glc) do
        M[k] = v
    end

%s

end

return M
]],
        kv
    ))
    w:close()

    print("done.")
end

generate(...)
