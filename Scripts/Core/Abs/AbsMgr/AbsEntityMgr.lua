AbsEntityMgr = Class.NewClass('AbsEntityMgr')
Class.DerivedInterface(AbsEntityMgr, ILifeCycle, IFixedUpdate, IUpdate, ILateUpdate)

function AbsEntityMgr:Ctor()
    self.entitys = {}
end
function AbsEntityMgr:OnInit()
end

function AbsEntityMgr:OnRemove()
    self.entitys = {}
end

function AbsEntityMgr:OnFixedUpdate(delta)
    for k, v in pairs(self.entitys) do
        for __, k_ in pairs(v) do
            if k_:Is(IFixedUpdate.type) then
                k_:OnFixedUpdate(delta)
            end
        end
    end
end

function AbsEntityMgr:OnUpdate(delta)
    for k, v in pairs(self.entitys) do
        for __, k_ in pairs(v) do
            if k_:Is(IUpdate.type) and k_.IsUpdate == true then
                k_:OnUpdate(delta)
            end
        end
    end
end

function AbsEntityMgr:OnLateUpdate(delta)
    for k, v in pairs(self.entitys) do
        for __, k_ in pairs(v) do
            if k_:Is(ILateUpdate.type) then
                k_:OnLateUpdate(delta)
            end
        end
    end
end

function AbsEntityMgr:AddEntity(group, entity)
    if group == nil or entity == nil then
        print('group or entity is nil')
        return
    end
    if not TableUtil.HasKey(self.entitys, group) then
        self.entitys[group] = {}
    end
    local entityGroup = self.entitys[group]
    if not TableUtil.HasValue(entityGroup, entity) then
        entityGroup[entity.id] = entity
        if entity:Is(ILifeCycle.type) then
            entity:OnInit()
        end
    end
end

function AbsEntityMgr:RemoveEntity(group, entity)
    if group == nil or entity == nil then
        print('group or entity is nil')
        return
    end
    local entityGroup = self.entitys[group]
    if not entityGroup then
        print('entity is nil')
        return
    end
    if TableUtil.HasKey(entityGroup, entity.id) then
        if entity:Is(ILifeCycle.type) then
            entity:OnRemove()
        end
        entityGroup[entity.id] = nil
    end
end

function AbsEntityMgr:RemoveEntitys(group)
    if group == nil then
        print('group is nil')
        return
    end
    local entityGroup = self.entitys[group]
    if entityGroup == nil then
        print('entityGroup is nil')
        return
    end
    local entitys = self.entitys[group]
    for k, v in pairs(entitys) do
        if v:Is(ILifeCycle.type) then
            v:OnRemove()
        end
    end
    entitys = nil
end

function AbsEntityMgr:GetEntityById(entityId)
    local et = nil
    for k, v in pairs(self.entitys) do
        for eid, e in pairs(v) do
            if eid == entityId then
                et = e
                break
            end
        end
    end
    return et
end

function AbsEntityMgr:GetEntitysByGroup(group)
    if group == nil then
        print('group is nil')
        return
    end
    return self.entitys[group]
end

function AbsEntityMgr:GetEntityByGroup(group, entityId)
    local et = nil
    if group == nil or entityId == nil then
        print('group or entityId is nil')
        return
    end
    if TableUtil.HasKey(self.entitys, group) then
        local gr = self.entitys[group]
        for k, v in pairs(gr) do
            if k == entityId then
                et = v
                break
            end
        end
    end
    return et
end
