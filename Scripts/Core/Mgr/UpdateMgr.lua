UpdateMgr = Class.NewClass('UpdateMgr')

Class.DerivedInterface(UpdateMgr, ILifeCycle, IUpdate)

local FuncWarp = Class.NewClass('FuncWarp')
function FuncWarp:Ctor(func,updateMgr)
    self.fId = updateMgr.idMgr:Next()
    self.func = func
end

function UpdateMgr:Ctor()
    self.idMgr = GenerateIdMgr.New()
    self.updateFunctions = {}
end

function UpdateMgr:OnInit()
end

function UpdateMgr:OnRemove()
    self.updateFunctions = {}
end

function UpdateMgr:OnUpdate(delta)
    for k,v in pairs(self.updateFunctions) do
        v.func(delta)
    end
end

function UpdateMgr:RegisterFunction(func)
    if not self:IsRegister(func) then
        local fWarp = FuncWarp.New(func,self)
        self.updateFunctions[fWarp.fId] = fWarp
    end
end

function UpdateMgr:UnRegisterFunction(func)
    local flag , fId = self:IsRegister(func)
    if flag then
        self.updateFunctions[fId] = nil
    end
end

function UpdateMgr:IsRegister(func)
    local flag = false
    local fId
    for k, v in pairs(self.updateFunctions) do
        if v.func == func then
            flag = true
            fId = v.fId
            break
        end
    end
    return flag , fId
end
