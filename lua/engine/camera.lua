local maf = require "mafex"
local utils = require "limgui.utils"

local M = {}

---@class Camera
---@field shift vec3
---@field yaw_degree number
---@field pietch_degree number
---@field view mat4
---@field projection mat4
M.OrbitCamera = {
    matrix = function(self)
        return self.view * self.projection
    end,

    --projection
    update_projection = function(self)
        self.projection = maf.mat4.perspective(self.fovy_degree, self.width / self.height, self.near, self.far)
    end,

    resize = function(self, w, h)
        self.width = w
        self.height = h
        self:update_projection()
    end,

    --view
    update_view = function(self)
        self.view = maf.mat4.rotation_y(self.yaw_degree)
            * maf.mat4.rotation_x(self.pitch_degree)
            * maf.mat4.translation(self.shift)
    end,

    mouse_move = function(self, x, y)
        if self.x then
            local dx = x - self.x
            local dy = y - self.y
            if self.mouse_right then
                self.yaw_degree = self.yaw_degree + dx
                self.pitch_degree = self.pitch_degree - dy
                self:update_view()
            end
            if self.mouse_middle then
                local t = math.tan(self.fovy_degree * 0.5 * math.pi / 180)
                self.shift.x = self.shift.x - (dx / self.height) * t * self.shift.z * 2
                self.shift.y = self.shift.y + (dy / self.height) * t * self.shift.z * 2
                self:update_view()
            end
        end
        self.x = x
        self.y = y
    end,

    mouse_button = function(self, button, is_down)
        if button == 0 then
            self.mouse_left = is_down
        elseif button == 1 then
            self.mouse_right = is_down
        elseif button == 2 then
            self.mouse_middle = is_down
        end
    end,

    mouse_wheel = function(self, d)
        if d > 0 then
            self.shift.z = self.shift.z * 0.9
            self:update_view()
        elseif d < 0 then
            self.shift.z = self.shift.z * 1.1
            self:update_view()
        end
    end,
}

M.OrbitCamera.new = function(width, height)
    local camera = utils.new(M.OrbitCamera, {
        projection = maf.mat4.identity(),
        near = 0.01,
        far = 100,
        fovy_degree = 50,
        width = width or 1,
        height = height or 1,

        view = maf.mat4.identity(),
        shift = maf.vec3(0, 0, -5),
        yaw_degree = 0,
        pitch_degree = 0,

        mouse_left = false,
        mouse_middle = false,
        mouse_right = false,
    })
    camera:update_projection()
    camera:update_view()
    return camera
end

return M
