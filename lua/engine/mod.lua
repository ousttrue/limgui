local M = {}

M.Renderer = require("engine.renderer").Renderer
M.OrbitCamera = require("engine.camera").OrbitCamera

-- like GLAD
M.load = function(glfw)
    local gl = require "gl_ffi.mod"
    gl.load(glfw)
end

return M
