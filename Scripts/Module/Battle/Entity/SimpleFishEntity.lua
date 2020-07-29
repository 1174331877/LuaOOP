SimpleFishEntity = Class.DerivedClass(AbsEntity, "SimpleFishEntity")

function SimpleFishEntity:Ctor()
    self.fishScale = 2
    self.fishName = "测试鱼"
end

function SimpleFishEntity:OnInit()
    self:AddComponent(LookAtComponent.New())
end

function SimpleFishEntity:OnRemove()
end

function SimpleFishEntity:OnFixedUpdate(delta)
end

function SimpleFishEntity:OnUpdate(delta)
end

function SimpleFishEntity:OnLateUpdate(delta)
end