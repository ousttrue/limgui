local ffi = require("ffi")
local utils = require("limgui.utils")
local glfw = require("libs.gl_ffi.glfw")
local M = {}
local gl = require("libs.gl_ffi.mod")

---@class Renderer
M.Renderer = {
    --- clear active RenderBuffer
    ---@param self Renderer
    ---@param w any
    ---@param h any
    ---@param clear_color table
    clear = function(self, w, h, clear_color)
        gl.load(glfw)
        gl.glViewport(0, 0, w, h)
        gl.glClearColor(
            clear_color[0] * clear_color[3],
            clear_color[1] * clear_color[3],
            clear_color[2] * clear_color[3],
            clear_color[3]
        )
        gl.glClear(gl.GL_COLOR_BUFFER_BIT)
    end,

    ---render scene
    ---@param self Renderer
    ---@param scene Scene
    render = function(self, scene)
        scene:render()
    end,
}
M.Renderer.new = function()
    return utils.new(M.Renderer, {})
end

return M
