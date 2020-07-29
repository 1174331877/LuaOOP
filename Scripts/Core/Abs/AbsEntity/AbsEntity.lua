AbsEntity = Class.DerivedInterface(Class.NewClass("AbsEntity"),ILifeCycle,IEntity)

function AbsEntity:Ctor(entityData)
    self.entityIdMgr = GenerateIdMgr.New()
    self.id = self.entityIdMgr:Next()
    self.entityData = entityData
    self.components = {}
end

function AbsEntity:HasComponent(type)
    return self:GetComponent(type) ~= nil
end

function AbsEntity:GetComponent(type)
    for k, v in pairs(self.components) do
        if v:Is(type) then
            return v
        end
    end
end

function AbsEntity:GetComponents(type)
    local ret = nil
    for k, v in pairs(self.components) do
        if v.Is(v,type) then
            if ret == nil then
                ret = {}
            end
            table.insert(ret, v)
        end
    end
    return ret
end

function AbsEntity:AddComponent(com)
    if com == nil or self:HasComponent(com.type) then
        return
    end
    com.entity = self
    if com:Is(ILifeCycle.type) then
        com:OnInit()
    end
    self.components[com.type] = com
end

function AbsEntity:RemoveComponent(com)
    if com == nil or not self:HasComponent(com.type) then
        return
    end
    if com:Is(ILifeCycle.type) then
        com:OnRemove()
    end
    self.components[com.type] = nil
end

