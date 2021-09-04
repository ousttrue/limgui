local utils = require "limgui.utils"
local maf = require "mafex"
local M = {}

---@class TRS
---@field t vec3
---@field r quat
---@field s vec3
---@field matrix mat4

---@class SceneNode
---@field name string
---@field transform TRS
---@field mesh SceneMesh
---@field parent SceneNode
---@field children SceneNode[]
M.SceneNode = {

    ---comment
    ---@param self SceneNode
    ---@param child SceneNode
    add_child = function(self, child)
        table.insert(self.children, child)
        child.parent = self
    end,

    ---comment
    ---@param self SceneNode
    matrix = function(self)
        if self.transform.matrix then
            return self.transform.matrix
        else
            return maf.mat4.trs(self.transform.t, self.transform.r, self.transform.s)
        end
    end,

    ---comment
    ---@param self SceneNode
    ---@return mat3
    inverse_matrix = function(self)
        if self.transform.matrix then
            assert(false, "not implemented")
        else
            return maf.mat3.rotation(self.transform.r):transpose() * maf.mat3.scale(-self.transform.s)
        end
    end,

    ---inverse transpose
    ---@param self any
    normal_matrix = function(self)
        return maf.mat4.scale(-self.transform.s) * maf.mat4.rotation(self.transform.r)
    end,
}

---comment
---@param name string
---@return SceneNode
M.SceneNode.new = function(name)
    return utils.new(M.SceneNode, {
        name = name,
        transform = {},
        children = {},
    })
end

return M
