require('Util.TableUtil')
Class = {}
--类型缓存
ClassTypeTrace = {}

--深度克隆一个表的所有值到target表中
function DeepClone(origen, target)
    if origen == nil then
        return {}
    end
    local ret = target or {}
    --克隆表层字段
    for k, v in pairs(origen) do
        if type(v) == 'table' then
            ret[k] = DeepClone(v, {})
        else
            ret[k] = v
        end
    end
    --克隆原表
    local meta = getmetatable(origen)
    if meta then
        local newMeta = DeepClone(meta, {})
        setmetatable(ret, newMeta)
    end
    return ret
end

--[[
    类型转换,模拟C# as 关键字
]]
function As(c, type)
    if c.type == type then
        return c
    elseif c.interfaces ~= nil then
        for k, v in pairs(c.interfaces) do
            if v.type == type then
                return v
            end
        end
    elseif c.base ~= nil then
        return c.base.As(c.base, type)
    end
end

--[[
    类型判断,模拟C# is 关键字
]]
function Is(c,type)
    if c.type == type then
        return true
    end
    if c.interfaces ~= nil then
        for k, v in pairs(c.interfaces) do
            if v.type == type then
                return true
            end
        end
    end
    if c.base ~= nil then
        return c.base:Is(type)
    end
    return false
end

--[[
    ToString方法
]]
function ToString(c)
    return tostring(c.type)
end

--[[
    返回类型得所有父类
]]
function GetClassAllBase(o,t)
    if o == nil or t == nil then
        return
    end
    while(true) do
        if o.base ~= nil then
            table.insert(t, o.base)
            GetClassAllBase(o.base, t)
            break
        else
            break
        end
    end
end

--[[
    实例化一个类型模板实例
]]
function Class.NewClass(typeStr)
    local t = typeStr or 'EmptyClass'
    if TableUtil.HasKey(ClassTypeTrace, t) then
        return ClassTypeTrace[t]
    end
    local ret = {}
    ret.type = t
    ret.interfaces = {}
    --实例化一个类型实例
    ret.Ctor = function()
    end
    --一个类型的实例化对象
    ret.New = function(...)
        local ins = DeepClone(ret, {})
        local bases = {}
        table.insert(bases, ins)
        --按照继承树状结构的父对象
        GetClassAllBase(ins,bases)
        --按照继承顺序调用构造函数
        for i = #bases, 1 , -1 do
            local bas = bases[i]
            --可以调用有参得构造函数
            bas.Ctor(bas,...)
        end
        return ins
    end
    ret.As = As
    ret.Is = Is
    ret.ToString = ToString
    ClassTypeTrace[t] = ret
    return ret
end

--[[
    C#单一继承
]]
function Class.DerivedClass(origen, typeStr)
    local ret = Class.NewClass(typeStr)
    local parent = {}
    DeepClone(origen, parent)
    ret.base = parent
    parent.__index = function(c, k)
        for __, v in pairs(c.interfaces) do
            if v[k] ~= nil then
                return v[k]
            end
        end
        return c.base[k]
    end
    return setmetatable(ret, parent)
end

--[[
    C#接口的多重继承
]]
function Class.DerivedInterface(origen, ...)
    local ret = origen
    local inters = {...}
    local interfaces = {}
    for k, v in pairs(inters) do
        local inter = DeepClone(v)
        interfaces[inter.type] = inter
    end
    ret.interfaces = interfaces
    local compose = {}
    compose.__index = function(c,k)
        if c.interfaces ~= nil then
            for __, v in pairs(c.interfaces) do
                if v[k] ~= nil then
                    return v[k]
                end
            end
        end
    end
    return setmetatable(ret, compose)
end

--[[
    C#继承一个父类,多个接口
]]
function Class.DerivedClassAndInterface(typeStr, origen, ...)
    local ret = Class.DerivedClass(origen, typeStr)
    Class.DerivedInterface(ret, ...)
    return ret
end
