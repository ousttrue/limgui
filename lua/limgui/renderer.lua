local ffi = require("ffi")
local utils = require("limgui.utils")
local glfw = require("libs.gl_ffi.glfw")
local M = {}

local vertex_shader_text = [[#version 110
attribute vec2 vPos;
void main()
{
    gl_Position = vec4(vPos, 0.0, 1.0);
};
]]

local fragment_shader_text = [[#version 110
void main()
{
    gl_FragColor = vec4(1, 1, 1, 1);
};
]]

local gllib = require("libs.gl_ffi.gl")
local initialized = false
local program
local function initialize()
    if initialized then
        return
    end
    initialized = true
    -- glad.gladLoadGL(glfw.getProcAddress)
    gllib.set_loader(glfw)
    -- gl, glc, glu, glext = gllib.libraries()

    local vertex_buffer = ffi.new("GLuint[1]")
    gllib.glext.glGenBuffers(1, vertex_buffer)
    gllib.glext.glBindBuffer(gllib.glc.GL_ARRAY_BUFFER, vertex_buffer[0])

    -- static const struct
    -- {
    --     float x, y;
    --     float r, g, b;
    -- } vertices[3] =
    -- {
    --     { -0.6f, -0.4f, 1.f, 0.f, 0.f },
    --     {  0.6f, -0.4f, 0.f, 1.f, 0.f },
    --     {   0.f,  0.6f, 0.f, 0.f, 1.f }
    -- };
    local vertices = ffi.new("float[3][2]")
    -- 0
    vertices[0][0] = -0.6
    vertices[0][1] = -0.4
    -- 1
    vertices[1][0] = 0.6
    vertices[1][1] = -0.4
    -- 2
    vertices[2][0] = 0.0
    vertices[2][1] = 0.6
    gllib.glext.glBufferData(gllib.glc.GL_ARRAY_BUFFER, ffi.sizeof(vertices), vertices, gllib.glc.GL_STATIC_DRAW)

    local vertex_shader = gllib.glext.glCreateShader(gllib.glc.GL_VERTEX_SHADER)
    local pp = ffi.new("const char *[1]")
    pp[0] = vertex_shader_text
    gllib.glext.glShaderSource(vertex_shader, 1, pp, nil)
    gllib.glext.glCompileShader(vertex_shader)

    local fragment_shader = gllib.glext.glCreateShader(gllib.glc.GL_FRAGMENT_SHADER)
    pp[0] = fragment_shader_text
    gllib.glext.glShaderSource(fragment_shader, 1, pp, nil)
    gllib.glext.glCompileShader(fragment_shader)

    program = gllib.glext.glCreateProgram()
    gllib.glext.glAttachShader(program, vertex_shader)
    gllib.glext.glAttachShader(program, fragment_shader)
    gllib.glext.glLinkProgram(program)

    -- local mvp_location = glext.glGetUniformLocation(program, "MVP")
    local vpos_location = gllib.glext.glGetAttribLocation(program, "vPos")
    gllib.glext.glEnableVertexAttribArray(vpos_location)
    gllib.glext.glVertexAttribPointer(vpos_location, 2, gllib.glc.GL_FLOAT, gllib.glc.GL_FALSE, 8, nil)
end

M.Renderer = {
    render = function(self, width, height)
        initialize()

        --         mat4x4 m, p, mvp;
        local ratio = width / height

        gllib.gl.glViewport(0, 0, width, height)
        gllib.gl.glClear(gllib.glc.GL_COLOR_BUFFER_BIT)

        --         mat4x4_identity(m);
        --         mat4x4_rotate_Z(m, m, (float) glfwGetTime());
        --         mat4x4_ortho(p, -ratio, ratio, -1.f, 1.f, 1.f, -1.f);
        --         mat4x4_mul(mvp, p, m);

        gllib.glext.glUseProgram(program)
        --         glUniformMatrix4fv(mvp_location, 1, GL_FALSE, (const GLfloat*) mvp);
        gllib.gl.glDrawArrays(gllib.glc.GL_TRIANGLES, 0, 3)
    end,
}
M.Renderer.new = function()
    return utils.new(M.Renderer, {})
end

return M
