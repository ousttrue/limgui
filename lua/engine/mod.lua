local M = {}

M.Renderer = require("engine.renderer").Renderer
M.Scene = require("engine.scene").Scene

-- like GLAD
M.load = function(glfw)
    local gl = require "libs.gl_ffi.mod"
    gl.load(glfw)
end

return M
