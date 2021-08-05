local ffi = require("ffi")
local gl = require("libs.gl_ffi.mod")
local utils = require("limgui.utils")

local M = {}

--- Get vertex attribute layouts from vertex shader source
local function parse_vs(vs)
    local layouts = {}
    for l in vs:gmatch("([^\n]+)") do
        local t, name = l:match("attribute%s+(vec%d)%s+(%w+);")
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

M.MVP_vs = [[#version 110
uniform mat4 MVP;
attribute vec2 vPos;
attribute vec3 vCol;
varying vec3 color;
void main()
{
    gl_Position = MVP * vec4(vPos, 0.0, 1.0);
    color = vCol;
};
]]

M.MVP_fs = [[#version 110
varying vec3 color;
void main()
{
    gl_FragColor = vec4(color, 1.0);
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
M.Shader.create = function(vs, fs)
    local vertex_shader = gl.glCreateShader(gl.GL_VERTEX_SHADER)
    local pp = ffi.new("const char *[1]")
    pp[0] = vs
    gl.glShaderSource(vertex_shader, 1, pp, nil)
    gl.glCompileShader(vertex_shader)

    local fragment_shader = gl.glCreateShader(gl.GL_FRAGMENT_SHADER)
    pp[0] = fs
    gl.glShaderSource(fragment_shader, 1, pp, nil)
    gl.glCompileShader(fragment_shader)

    local program = gl.glCreateProgram()
    gl.glAttachShader(program, vertex_shader)
    gl.glAttachShader(program, fragment_shader)
    gl.glLinkProgram(program)

    return utils.new(M.Shader, {
        program = program,
        vertex_attributes = {},
        location_map = {},
    })
end

M.create = function(name)
    local vs_name = name .. "_vs"
    local fs_name = name .. "_fs"
    local shader = M.Shader.create(M[vs_name], M[fs_name])

    local layouts = parse_vs(M[vs_name])
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
