
BattleBehaviour = Class.DerivedClass(AbsBehaviour, "BattleBehaviour")

function BattleBehaviour:Ctor()
    self.EntityMgr = BattleEntityMgr.New()
end

function BattleBehaviour:OnInit()
    self.EntityMgr:OnInit()
end

function BattleBehaviour:OnRemove()
    self.EntityMgr:OnRemove()
end

function BattleBehaviour:OnFixedUpdate(delta)
    self.EntityMgr:OnFixedUpdate(delta)
end

function BattleBehaviour:OnUpdate(delta)
    self.EntityMgr:OnUpdate(delta)
end

function BattleBehaviour:OnLateUpdate(delta)
    self.EntityMgr:OnLateUpdate(delta)
end