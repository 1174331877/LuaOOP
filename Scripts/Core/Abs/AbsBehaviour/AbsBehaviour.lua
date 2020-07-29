AbsBehaviour = Class.NewClass("AbsBehaviour")

Class.DerivedInterface(AbsBehaviour,ILifeCycle,IFixedUpdate,IUpdate,ILateUpdate)

function AbsBehaviour:OnInit()
end

function AbsBehaviour:OnRemove()
end

function AbsBehaviour:OnFixedUpdate(delta)
end

function AbsBehaviour:OnUpdate(delta)
end

function AbsBehaviour:OnLateUpdate(delta)
end
