ILifeCycle = Class.NewClass("ILifeCycle")

function ILifeCycle:OnInit()
    print("ILifeCycle:OnInit")
end

function ILifeCycle:OnRemove()
    print("ILifeCycle:OnRemove")
end