LookAtComponent = Class.DerivedClassAndInterface("LookAtComponent",AbsComponent,IUpdate)

function LookAtComponent:OnInit()
    print("LookAtComponent:OnInit")
end

function LookAtComponent:OnRemove()
    print("LookAtComponent:OnRemove")
end

function LookAtComponent:OnUpdate(delta)
    print("LookAtComponent:OnUpdate\t"..delta)
end

function LookAtComponent:StopLookAt()
    self.IsUpdate = false
end

function LookAtComponent:ReStartLookAt()
    self.IsUpdate = true
end