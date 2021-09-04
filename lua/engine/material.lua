local ffi = require "ffi"

ffi.cdef [[
typedef unsigned char stbi_uc;
typedef unsigned short stbi_us;
stbi_uc *stbi_load_from_memory   (stbi_uc           const *buffer, int len   , int *x, int *y, int *channels_in_file, int desired_channels);
void     stbi_image_free      (void *retval_from_stbi_load);
]]

local gl = require "gl_ffi.mod"
local utils = require "limgui.utils"
local M = {}

---@class EngineTexture
---@field id ffi.cdata*
M.EngineTexture = {}

---comment
---@param src SceneTexture
M.EngineTexture.load = function(src)
    if not M.stb then
        M.stb = ffi.load "stb"
    end
    local id = ffi.new "GLuint[1]"
    local texture = {
        id = id,
    }

    -- debug
    -- local w = io.open(src.name or "tmp.png", "wb")
    -- w:write(ffi.string(src.bytes, src.length))
    -- w:close()

    local x = ffi.new "int[1]"
    local y = ffi.new "int[1]"
    local channels = ffi.new "int[1]"
    local image = M.stb.stbi_load_from_memory(src.bytes, src.length, x, y, channels, 4)
    if image == ffi.NULL then
        print "fail to load image"
    else
        print(x[0], y[0], channels[0])
        gl.glGenTextures(1, id)
        gl.glBindTexture(gl.GL_TEXTURE_2D, id[0])

        gl.glEnable(gl.GL_TEXTURE_2D)
        gl.glTexImage2D(gl.GL_TEXTURE_2D, 0, gl.GL_RGBA, x[0], y[0], 0, gl.GL_RGBA, gl.GL_UNSIGNED_BYTE, image)
        gl.glTexParameterf(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MAG_FILTER, gl.GL_LINEAR)
        gl.glTexParameterf(gl.GL_TEXTURE_2D, gl.GL_TEXTURE_MIN_FILTER, gl.GL_LINEAR)
        gl.glBindTexture(gl.GL_TEXTURE_2D, 0)
        gl.glDisable(gl.GL_TEXTURE_2D)
    end
    M.stb.stbi_image_free(image)

    return texture
end

---@class EngineMaterial
---@field shader EngineShader
---@field base_texture EngineTexture
M.EngineMaterial = {
    ---comment
    ---@param self EngineMaterial
    ---@param variables any
    activate = function(self, variables)
        self.shader:activate(variables)

        if self.base_texture then
            gl.glActiveTexture(gl.GL_TEXTURE0)
            gl.glEnable(gl.GL_TEXTURE_2D)
            gl.glBindTexture(gl.GL_TEXTURE_2D, self.base_texture.id[0])
        else
            gl.glActiveTexture(gl.GL_TEXTURE0)
            gl.glDisable(gl.GL_TEXTURE_2D)
        end
    end,
}

M.EngineMaterial.new = function(shader)
    return utils.new(M.EngineMaterial, {
        shader = shader,
    })
end

return M
