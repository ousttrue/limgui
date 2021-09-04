-- maf
-- https://github.com/bjornbytes/maf
-- MIT License
--
-- [extended]
-- * mat4
-- * mat3
-- * vec4
-- * vec2

local ffi = type(jit) == "table" and jit.status() and require "ffi"
local vec2, vec3, vec4, quat, mat3, mat4

local M = {}

local forward
local vtmp1
local vtmp2
local qtmp1

---@class vec2
---@field x number
---@field y number
vec2 = {
    __call = function(_, x, y)
        return setmetatable({ x = x or 0, y = y or 0 }, vec2)
    end,

    __tostring = function(v)
        return string.format("(%f, %f)", v.x, v.y)
    end,
}

---@class vec3
---@field x number
---@field y number
---@field z number
vec3 = {
    __call = function(_, x, y, z)
        return setmetatable({ x = x or 0, y = y or 0, z = z or 0 }, vec3)
    end,

    __tostring = function(v)
        return string.format("(%f, %f, %f)", v.x, v.y, v.z)
    end,

    __add = function(v, u)
        return v:add(u, vec3())
    end,
    __sub = function(v, u)
        return v:sub(u, vec3())
    end,
    __mul = function(v, u)
        if vec3.isvec3(u) then
            return v:mul(u, vec3())
        elseif type(u) == "number" then
            return v:scale(u, vec3())
        else
            error "vec3s can only be multiplied by vec3s and numbers"
        end
    end,
    __div = function(v, u)
        if vec3.isvec3(u) then
            return v:div(u, vec3())
        elseif type(u) == "number" then
            return v:scale(1 / u, vec3())
        else
            error "vec3s can only be divided by vec3s and numbers"
        end
    end,
    __unm = function(v)
        return v:scale(-1)
    end,
    __len = function(v)
        return v:length()
    end,

    __index = {
        isvec3 = function(x)
            return ffi and ffi.istype("vec3", x) or getmetatable(x) == vec3
        end,

        clone = function(v)
            return vec3(v.x, v.y, v.z)
        end,

        unpack = function(v)
            return v.x, v.y, v.z
        end,

        set = function(v, x, y, z)
            if vec3.isvec3(x) then
                x, y, z = x.x, x.y, x.z
            end
            v.x = x
            v.y = y
            v.z = z
            return v
        end,

        add = function(v, u, out)
            out = out or v
            out.x = v.x + u.x
            out.y = v.y + u.y
            out.z = v.z + u.z
            return out
        end,

        sub = function(v, u, out)
            out = out or v
            out.x = v.x - u.x
            out.y = v.y - u.y
            out.z = v.z - u.z
            return out
        end,

        mul = function(v, u, out)
            out = out or v
            out.x = v.x * u.x
            out.y = v.y * u.y
            out.z = v.z * u.z
            return out
        end,

        div = function(v, u, out)
            out = out or v
            out.x = v.x / u.x
            out.y = v.y / u.y
            out.z = v.z / u.z
            return out
        end,

        scale = function(v, s, out)
            out = out or v
            out.x = v.x * s
            out.y = v.y * s
            out.z = v.z * s
            return out
        end,

        length = function(v)
            return math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z)
        end,

        normalize = function(v, out)
            out = out or v
            local len = v:length()
            return len == 0 and v or v:scale(1 / len, out)
        end,

        distance = function(v, u)
            return vec3.sub(v, u, vtmp1):length()
        end,

        angle = function(v, u)
            return math.acos(v:dot(u) / (v:length() + u:length()))
        end,

        dot = function(v, u)
            return v.x * u.x + v.y * u.y + v.z * u.z
        end,

        cross = function(v, u, out)
            out = out or v
            local a, b, c = v.x, v.y, v.z
            out.x = b * u.z - c * u.y
            out.y = c * u.x - a * u.z
            out.z = a * u.y - b * u.x
            return out
        end,

        lerp = function(v, u, t, out)
            out = out or v
            out.x = v.x + (u.x - v.x) * t
            out.y = v.y + (u.y - v.y) * t
            out.z = v.z + (u.z - v.z) * t
            return out
        end,

        project = function(v, u, out)
            out = out or v
            local unorm = vtmp1
            u:normalize(unorm)
            local dot = v:dot(unorm)
            out.x = unorm.x * dot
            out.y = unorm.y * dot
            out.z = unorm.z * dot
            return out
        end,

        rotate = function(v, q, out)
            out = out or v
            local u, c, o = vtmp1, vtmp2, out
            u.x, u.y, u.z = q.x, q.y, q.z
            o.x, o.y, o.z = v.x, v.y, v.z
            u:cross(v, c)
            local uu = u:dot(u)
            local uv = u:dot(v)
            o:scale(q.w * q.w - uu)
            u:scale(2 * uv)
            c:scale(2 * q.w)
            return o:add(u:add(c))
        end,
    },
}

---@class vec4
---@field x number
---@field y number
---@field z number
---@field w number
vec4 = {
    __call = function(_, x, y, z, w)
        return setmetatable({ x = x or 0, y = y or 0, z = z or 0, w = w or 0 }, vec3)
    end,

    __tostring = function(v)
        return string.format("(%f, %f, %f, %f)", v.x, v.y, v.z, v.w)
    end,
}

---@class quat
---@field x number
---@field y number
---@field z number
---@field w number
quat = {
    __call = function(_, x, y, z, w)
        return setmetatable({ x = x, y = y, z = z, w = w }, quat)
    end,

    __tostring = function(q)
        return string.format("(%f, %f, %f, %f)", q.x, q.y, q.z, q.w)
    end,

    __add = function(q, r)
        return q:add(r, quat())
    end,
    __sub = function(q, r)
        return q:sub(r, quat())
    end,
    __mul = function(q, r)
        if quat.isquat(r) then
            return q:mul(r, quat())
        elseif vec3.isvec3(r) then
            return r:rotate(q, vec3())
        else
            error "quats can only be multiplied by quats and vec3s"
        end
    end,
    __unm = function(q)
        return q:scale(-1)
    end,
    __len = function(q)
        return q:length()
    end,

    __index = {
        isquat = function(x)
            return ffi and ffi.istype("quat", x) or getmetatable(x) == quat
        end,

        clone = function(q)
            return quat(q.x, q.y, q.z, q.w)
        end,

        unpack = function(q)
            return q.x, q.y, q.z, q.w
        end,

        set = function(q, x, y, z, w)
            if quat.isquat(x) then
                x, y, z, w = x.x, x.y, x.z, x.w
            end
            q.x = x
            q.y = y
            q.z = z
            q.w = w
            return q
        end,

        fromAngleAxis = function(angle, x, y, z)
            return quat():setAngleAxis(angle, x, y, z)
        end,

        setAngleAxis = function(q, angle, x, y, z)
            if vec3.isvec3(x) then
                x, y, z = x.x, x.y, x.z
            end
            local s = math.sin(angle * 0.5)
            local c = math.cos(angle * 0.5)
            q.x = x * s
            q.y = y * s
            q.z = z * s
            q.w = c
            return q
        end,

        getAngleAxis = function(q)
            if q.w > 1 or q.w < -1 then
                q:normalize()
            end
            local s = math.sqrt(1 - q.w * q.w)
            s = s < 0.0001 and 1 or 1 / s
            return 2 * math.acos(q.w), q.x * s, q.y * s, q.z * s
        end,

        between = function(u, v)
            return quat():setBetween(u, v)
        end,

        setBetween = function(q, u, v)
            local dot = u:dot(v)
            if dot > 0.99999 then
                q.x, q.y, q.z, q.w = 0, 0, 0, 1
                return q
            elseif dot < -0.99999 then
                vtmp1.x, vtmp1.y, vtmp1.z = 1, 0, 0
                vtmp1:cross(u)
                if #vtmp1 < 0.00001 then
                    vtmp1.x, vtmp1.y, vtmp1.z = 0, 1, 0
                    vtmp1:cross(u)
                end
                vtmp1:normalize()
                return q:setAngleAxis(math.pi, vtmp1)
            end

            q.x, q.y, q.z = u.x, u.y, u.z
            vec3.cross(q, v)
            q.w = 1 + dot
            return q:normalize()
        end,

        fromDirection = function(x, y, z)
            return quat():setDirection(x, y, z)
        end,

        setDirection = function(q, x, y, z)
            if vec3.isvec3(x) then
                x, y, z = x.x, x.y, x.z
            end
            vtmp2.x, vtmp2.y, vtmp2.z = x, y, z
            return q:setBetween(forward, vtmp2)
        end,

        add = function(q, r, out)
            out = out or q
            out.x = q.x + r.x
            out.y = q.y + r.y
            out.z = q.z + r.z
            out.w = q.w + r.w
            return out
        end,

        sub = function(q, r, out)
            out = out or q
            out.x = q.x - r.x
            out.y = q.y - r.y
            out.z = q.z - r.z
            out.w = q.w - r.w
            return out
        end,

        mul = function(q, r, out)
            out = out or q
            local qx, qy, qz, qw = q:unpack()
            local rx, ry, rz, rw = r:unpack()
            out.x = qx * rw + qw * rx + qy * rz - qz * ry
            out.y = qy * rw + qw * ry + qz * rx - qx * rz
            out.z = qz * rw + qw * rz + qx * ry - qy * rx
            out.w = qw * rw - qx * rx - qy * ry - qz * rz
            return out
        end,

        scale = function(q, s, out)
            out = out or q
            out.x = q.x * s
            out.y = q.y * s
            out.z = q.z * s
            out.w = q.w * s
            return out
        end,

        length = function(q)
            return math.sqrt(q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w)
        end,

        normalize = function(q, out)
            out = out or q
            local len = q:length()
            return len == 0 and q or q:scale(1 / len, out)
        end,

        lerp = function(q, r, t, out)
            out = out or q
            r:scale(t, qtmp1)
            q:scale(1 - t, out)
            return out:add(qtmp1)
        end,

        slerp = function(q, r, t, out)
            out = out or q

            local dot = q.x * r.x + q.y * r.y + q.z * r.z + q.w * r.w
            if dot < 0 then
                dot = -dot
                r:scale(-1)
            end

            if 1 - dot < 0.0001 then
                return q:lerp(r, t, out)
            end

            local theta = math.acos(dot)
            q:scale(math.sin((1 - t) * theta), out)
            r:scale(math.sin(t * theta), qtmp1)
            return out:add(qtmp1):scale(1 / math.sin(theta))
        end,
    },
}

---@class mat3
---@field _11 number
---@field _12 number
---@field _13 number
---@field _21 number
---@field _22 number
---@field _23 number
---@field _31 number
---@field _32 number
---@field _33 number
mat3 = {
    __call = function(
        _, --
        _11,
        _12,
        _13,
        _21,
        _22,
        _23,
        _31,
        _32,
        _33
    )
        return setmetatable({
            _11 = _11,
            _12 = _12,
            _13 = _13,
            _21 = _21,
            _22 = _22,
            _23 = _23,
            _31 = _31,
            _32 = _32,
            _33 = _33,
        }, mat3)
    end,
    __mul = function(self, rhs)
        local m = mat3()

        m._11 = self._11 * rhs._11 + self._12 * rhs._21 + self._13 * rhs._31
        m._12 = self._11 * rhs._12 + self._12 * rhs._22 + self._13 * rhs._32
        m._13 = self._11 * rhs._13 + self._12 * rhs._23 + self._13 * rhs._33
        m._21 = self._21 * rhs._11 + self._22 * rhs._21 + self._23 * rhs._31
        m._22 = self._21 * rhs._12 + self._22 * rhs._22 + self._23 * rhs._32
        m._23 = self._21 * rhs._13 + self._22 * rhs._23 + self._23 * rhs._33
        m._31 = self._31 * rhs._11 + self._32 * rhs._21 + self._33 * rhs._31
        m._32 = self._31 * rhs._12 + self._32 * rhs._22 + self._33 * rhs._32
        m._33 = self._31 * rhs._13 + self._32 * rhs._23 + self._33 * rhs._33

        return m
    end,

    __index = {
        identity = function()
            local m = mat3()
            m._11 = 1
            m._22 = 1
            m._33 = 1
            return m
        end,

        ---@param s vec3
        ---@return mat3
        scale = function(s)
            local m = mat3()
            m._11 = s.x
            m._22 = s.y
            m._33 = s.z
            return m
        end,

        ---comment
        ---@param q quat
        rotation = function(q)
            local x = q.x
            local y = q.y
            local z = q.z
            local w = q.w
            local m = mat3()
            m._11 = 1 - 2 * y * y - 2 * z * z
            m._22 = 1 - 2 * z * z - 2 * x * x
            m._33 = 1 - 2 * x * x - 2 * y * y
            m._31 = 2 * z * x + 2 * w * y
            m._13 = 2 * z * x - 2 * w * y
            m._12 = 2 * x * y + 2 * w * z
            m._21 = 2 * x * y - 2 * w * z
            m._23 = 2 * y * z + 2 * w * x
            m._32 = 2 * y * z - 2 * w * x
            return m
        end,

        ---1
        --- cS
        --- sc
        rotation_x = function(degree)
            local rad = degree / 180.0 * math.pi
            local c = math.cos(rad)
            local s = math.sin(rad)
            local m = mat3()

            m._11 = 1
            m._22 = c
            m._33 = c
            m._23 = -s
            m._32 = s

            return m
        end,

        ---c S
        --- 1
        ---s c
        rotation_y = function(degree)
            local rad = degree / 180.0 * math.pi
            local c = math.cos(rad)
            local s = math.sin(rad)
            local m = mat3()

            m._11 = c
            m._22 = 1
            m._33 = c
            m._13 = -s
            m._31 = s

            return m
        end,

        ---comment
        ---@param self mat3
        ---@return mat3
        transpose = function(self)
            local m = mat3()
            m._11 = self._11
            m._12 = self._21
            m._13 = self._31
            m._21 = self._12
            m._22 = self._22
            m._23 = self._32
            m._31 = self._13
            m._32 = self._23
            m._33 = self._33
            return m
        end,

        ---vec3 * mat3
        ---@param self mat3
        ---@param v vec3
        ---@return vec3
        apply = function(self, v)
            local x = v.x * self._11 + v.y * self._21 + v.z * self._31
            local y = v.y * self._12 + v.y * self._22 + v.z * self._32
            local z = v.z * self._13 + v.y * self._23 + v.z * self._33
            return vec3(x, y, z)
        end,
    },
}

--- R|0
--- -+-
--- T|1
--- * TRS
--- [x, y, z, w] * S * R * T
--- * MVP
--- [x, y, z, w] * M * V * P
---@class mat4
---@field _11 number
---@field _12 number
---@field _13 number
---@field _14 number
---@field _21 number
---@field _22 number
---@field _23 number
---@field _24 number
---@field _31 number
---@field _32 number
---@field _33 number
---@field _34 number
---@field _41 number
---@field _42 number
---@field _43 number
---@field _44 number
mat4 = {
    __call = function(
        _, --
        _11,
        _12,
        _13,
        _14,
        _21,
        _22,
        _23,
        _24,
        _31,
        _32,
        _33,
        _34,
        _41,
        _42,
        _43,
        _44
    )
        return setmetatable({
            _11 = _11,
            _12 = _12,
            _13 = _13,
            _14 = _14,
            _21 = _21,
            _22 = _22,
            _23 = _23,
            _24 = _24,
            _31 = _31,
            _32 = _32,
            _33 = _33,
            _34 = _34,
            _41 = _41,
            _42 = _42,
            _43 = _43,
            _44 = _44,
        }, mat4)
    end,

    __mul = function(self, rhs)
        local m = mat4()

        m._11 = self._11 * rhs._11 + self._12 * rhs._21 + self._13 * rhs._31 + self._14 * rhs._41
        m._12 = self._11 * rhs._12 + self._12 * rhs._22 + self._13 * rhs._32 + self._14 * rhs._42
        m._13 = self._11 * rhs._13 + self._12 * rhs._23 + self._13 * rhs._33 + self._14 * rhs._43
        m._14 = self._11 * rhs._14 + self._12 * rhs._24 + self._13 * rhs._34 + self._14 * rhs._44

        m._21 = self._21 * rhs._11 + self._22 * rhs._21 + self._23 * rhs._31 + self._24 * rhs._41
        m._22 = self._21 * rhs._12 + self._22 * rhs._22 + self._23 * rhs._32 + self._24 * rhs._42
        m._23 = self._21 * rhs._13 + self._22 * rhs._23 + self._23 * rhs._33 + self._24 * rhs._43
        m._24 = self._21 * rhs._14 + self._22 * rhs._24 + self._23 * rhs._34 + self._24 * rhs._44

        m._31 = self._31 * rhs._11 + self._32 * rhs._21 + self._33 * rhs._31 + self._34 * rhs._41
        m._32 = self._31 * rhs._12 + self._32 * rhs._22 + self._33 * rhs._32 + self._34 * rhs._42
        m._33 = self._31 * rhs._13 + self._32 * rhs._23 + self._33 * rhs._33 + self._34 * rhs._43
        m._34 = self._31 * rhs._14 + self._32 * rhs._24 + self._33 * rhs._34 + self._34 * rhs._44

        m._41 = self._41 * rhs._11 + self._42 * rhs._21 + self._43 * rhs._31 + self._44 * rhs._41
        m._42 = self._41 * rhs._12 + self._42 * rhs._22 + self._43 * rhs._32 + self._44 * rhs._42
        m._43 = self._41 * rhs._13 + self._42 * rhs._23 + self._43 * rhs._33 + self._44 * rhs._43
        m._44 = self._41 * rhs._14 + self._42 * rhs._24 + self._43 * rhs._34 + self._44 * rhs._44

        return m
    end,

    __index = {
        identity = function()
            local m = mat4()
            m._11 = 1
            m._22 = 1
            m._33 = 1
            m._44 = 1
            return m
        end,

        frustum = function(b, t, l, r, n, f)
            local m = mat4()
            m._11 = 2 * n / (r - l)
            m._22 = 2 * n / (t - b)

            m._31 = (r + l) / (r - l)
            m._32 = (t + b) / (t - b)
            m._33 = -(f + n) / (f - n)
            m._34 = -1

            m._43 = -2 * f * n / (f - n)

            return m
        end,

        ---like gluPerspective
        ---@param fovy_degree number
        ---@param aspectRatio number
        ---@param near number
        ---@param far number
        ---@return mat4
        perspective = function(fovy_degree, aspectRatio, near, far)
            local scale = math.tan(fovy_degree * 0.5 * math.pi / 180) * near
            local r = aspectRatio * scale
            local l = -r
            local t = scale
            local b = -t
            return mat4.frustum(b, t, l, r, near, far)
        end,

        translation = function(t)
            local m = mat4.identity()
            m._41 = t.x
            m._42 = t.y
            m._43 = t.z
            return m
        end,

        ---1
        --- cS
        --- sc
        rotation_x = function(degree)
            local rad = degree / 180.0 * math.pi
            local c = math.cos(rad)
            local s = math.sin(rad)
            local m = mat4()

            m._11 = 1
            m._22 = c
            m._33 = c
            m._44 = 1
            m._23 = -s
            m._32 = s

            return m
        end,

        ---c S
        --- 1
        ---s c
        rotation_y = function(degree)
            local rad = degree / 180.0 * math.pi
            local c = math.cos(rad)
            local s = math.sin(rad)
            local m = mat4()

            m._11 = c
            m._22 = 1
            m._33 = c
            m._44 = 1
            m._13 = -s
            m._31 = s

            return m
        end,

        ---cS
        ---sc
        ---  1
        rotation_z = function(degree)
            local rad = degree / 180.0 * math.pi
            local c = math.cos(rad)
            local s = math.sin(rad)
            local m = mat4()

            m._11 = c
            m._22 = c
            m._33 = 1
            m._44 = 1
            m._21 = -s
            m._12 = s

            return m
        end,

        ---comment
        ---@param q quat
        rotation = function(q)
            local x = q.x
            local y = q.y
            local z = q.z
            local w = q.w
            local m = mat4()
            m._11 = 1 - 2 * y * y - 2 * z * z
            m._22 = 1 - 2 * z * z - 2 * x * x
            m._33 = 1 - 2 * x * x - 2 * y * y
            m._44 = 1
            m._31 = 2 * z * x + 2 * w * y
            m._13 = 2 * z * x - 2 * w * y
            m._12 = 2 * x * y + 2 * w * z
            m._21 = 2 * x * y - 2 * w * z
            m._23 = 2 * y * z + 2 * w * x
            m._32 = 2 * y * z - 2 * w * x
            return m
        end,

        ---comment
        ---@param s vec3
        ---@return mat4
        scale = function(s)
            local m = mat4()
            m._11 = s.x
            m._22 = s.y
            m._33 = s.z
            m._44 = 1
            return m
        end,

        ---comment
        ---@param t vec3
        ---@param r quat
        ---@param s vec3
        trs = function(t, r, s)
            return mat4.scale(s) * mat4.rotation(r) * mat4.translation(t)
        end,

        transpose = function(self)
            local m = mat4()
            m._11 = self._11
            m._12 = self._21
            m._13 = self._31
            m._14 = self._41
            m._21 = self._12
            m._22 = self._22
            m._23 = self._32
            m._24 = self._42
            m._31 = self._13
            m._32 = self._23
            m._33 = self._33
            m._34 = self._43
            m._41 = self._14
            m._42 = self._24
            m._43 = self._34
            m._44 = self._44
            return m
        end,
    },
}

if ffi then
    ffi.cdef [[
    typedef struct { float x, y; } vec2;
    typedef struct { float x, y, z; } vec3;
    typedef struct { float x, y, z, w; } vec4;
    typedef struct { float x, y, z, w; } quat;
    typedef union {
        struct {
            float _11, _12, _13;
            float _21, _22, _23;
            float _31, _32, _33;
        };
        float array[9];
    } mat3;
    typedef union {
        struct {
            float _11, _12, _13, _14;
            float _21, _22, _23, _24;
            float _31, _32, _33, _34;
            float _41, _42, _43, _44;
        };
        float array[16];
    } mat4;
]]

    vec2 = ffi.metatype("vec2", vec2)
    vec3 = ffi.metatype("vec3", vec3)
    vec4 = ffi.metatype("vec4", vec4)
    quat = ffi.metatype("quat", quat)
    mat3 = ffi.metatype("mat3", mat3)
    mat4 = ffi.metatype("mat4", mat4)
else
    setmetatable(vec2, vec2)
    setmetatable(vec3, vec3)
    setmetatable(vec4, vec4)
    setmetatable(quat, quat)
    setmetatable(mat3, mat3)
    setmetatable(mat4, mat4)
end

forward = vec3(0, 0, -1)
vtmp1 = vec3()
vtmp2 = vec3()
qtmp1 = quat()
M.vec2 = vec2
M.vec3 = vec3
M.vec4 = vec4
M.quat = quat
M.mat3 = mat3
M.mat4 = mat4

return M
