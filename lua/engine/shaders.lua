local ffi = require "ffi"
local gl = require "gl_ffi.mod"
local utils = require "limgui.utils"

local M = {}

--- Get vertex attribute layouts from vertex shader source
local function parse_vs(vs)
    local layouts = {}
    local use_in = false
    for l in vs:gmatch "([^\n]+)" do
        if l:match "#version 400" then
            use_in = true
        else
            local t, name = l:match(use_in and "in%s+(vec%d)%s+(%w+);" or "attribute%s+(vec%d)%s+(%w+);")
            if t and name then
                local layout = {}
                if t == "vec2" then
                    layout.name = name
                    layout.element_type = gl.GL_FLOAT
                    layout.element_count = 2
                    layout.stride = 8
                    layout.normalized = gl.GL_FALSE
                elseif t == "vec3" then
                    layout.name = name
                    layout.element_type = gl.GL_FLOAT
                    layout.element_count = 3
                    layout.stride = 12
                    layout.normalized = gl.GL_FALSE
                else
                    assert(false)
                end
                table.insert(layouts, layout)
            end
        end
    end
    return layouts
end

--
-- minimal shader
--
M.MINIMAL_vs = [[#version 110
attribute vec2 vPos;
void main()
{
    gl_Position = vec4(vPos, 0.0, 1.0);
};
]]

M.MINIMAL_fs = [[#version 110
void main()
{
    gl_FragColor = vec4(1, 1, 1, 1);
};
]]

M.GLTF_vs = [[#version 110
uniform mat4 MVP;
attribute vec3 vPos;
attribute vec2 vCol;

void main()
{
    gl_Position = MVP * vec4(vPos, 1.0);
};
]]

M.GLTF_fs = [[#version 110
void main()
{
    gl_FragColor = vec4(1, 1, 1, 1);
};
]]

---@class VertexAttribute
---@field location any
---@field element_count number
---@field element_type any
---@field normalized any
---@field stride number
M.VertexAttribute = {
    activate = function(self)
        gl.glVertexAttribPointer(
            self.location,
            self.element_count,
            self.element_type,
            self.normalized,
            self.stride,
            self.offset
        )
    end,
}
M.VertexAttribute.new = function(location, layout, stride, offset)
    local instance = {
        location = location,
        offset = ffi.cast("void*", offset),
    }
    for k, v in pairs(layout) do
        instance[k] = v
    end
    instance.stride = stride
    return utils.new(M.VertexAttribute, instance)
end

---@class Shader
---@field program any
---@field vertex_attributes VertexAttribute[]
M.Shader = {
    activate = function(self, variables)
        -- set shader
        gl.glUseProgram(self.program)

        for k, v in pairs(variables) do
            local location = self.location_map[k]
            if not location then
                location = gl.glGetUniformLocation(self.program, k)
                self.location_map[k] = location
            end
            gl.glUniformMatrix4fv(location, 1, gl.GL_FALSE, ffi.cast("float *", v))
        end

        for i, va in ipairs(self.vertex_attributes) do
            -- activate vertex slot
            gl.glEnableVertexAttribArray(va.location)
            -- VBO layout
            va:activate()
        end
    end,
}

---comment
---@param source string
---@param shader_type integer
---@return integer
local function compile_shader(source, shader_type)
    local shader = gl.glCreateShader(shader_type)
    local pp = ffi.new "const char *[1]"
    pp[0] = source
    gl.glShaderSource(shader, 1, pp, nil)
    gl.glCompileShader(shader)

    local result = ffi.new "uint32_t[1]"
    gl.glGetShaderiv(shader, gl.GL_COMPILE_STATUS, result)
    if result[0] == gl.GL_FALSE then
        print("compile error", shader_type == gl.GL_VERTEX_SHADER and "vs" or "fs")
        local len = ffi.new "uint32_t[1]"
        gl.glGetShaderiv(shader, gl.GL_INFO_LOG_LENGTH, len)
        if len[0] > 0 then
            local log = ffi.new("char[?]", len[0])
            local written = ffi.new "uint32_t[1]"
            gl.glGetShaderInfoLog(shader, len[0], written, log)
            print(ffi.string(log))
        end
    end

    return shader
end

local function link_program(vertex_shader, fragment_shader)
    local program = gl.glCreateProgram()
    gl.glAttachShader(program, vertex_shader)
    gl.glAttachShader(program, fragment_shader)
    gl.glLinkProgram(program)
    local result = ffi.new "uint32_t[1]"
    gl.glGetProgramiv(program, gl.GL_LINK_STATUS, result)
    if result[0] == gl.GL_FALSE then
        print "link error"
        local len = ffi.new "uint32_t[1]"
        gl.glGetProgramiv(program, gl.GL_INFO_LOG_LENGTH, len)
        if len[0] > 0 then
            local log = ffi.new("char[?]", len[0])
            local written = ffi.new "uint32_t[1]"
            gl.glGetProgramInfoLog(program, len[0], written, log)
            print(ffi.string(log))
        end
    end

    return program
end

M.Shader.create = function(vs, fs)
    local vertex_shader = compile_shader(vs, gl.GL_VERTEX_SHADER)
    local fragment_shader = compile_shader(fs, gl.GL_FRAGMENT_SHADER)
    local program = link_program(vertex_shader, fragment_shader)
    return utils.new(M.Shader, {
        program = program,
        vertex_attributes = {},
        location_map = {},
    })
end

M.create = function(shader)
    local vs, fs
    if type(shader) == "table" then
        vs = shader.vs
        fs = shader.fs
    else
        local vs_name = shader .. "_vs"
        local fs_name = shader .. "_fs"
        vs = M[vs_name]
        fs = M[fs_name]
    end
    local shader = M.Shader.create(vs, fs)

    local layouts = parse_vs(vs)
    local stride = 0
    for i, layout in ipairs(layouts) do
        stride = stride + layout.stride
    end
    local offset = 0
    for i, layout in ipairs(layouts) do
        local position_location = gl.glGetAttribLocation(shader.program, layout.name)
        table.insert(shader.vertex_attributes, M.VertexAttribute.new(position_location, layout, stride, offset))
        offset = offset + layout.stride
    end

    return shader
end

return M
