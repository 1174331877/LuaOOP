AbsComponent = Class.DerivedInterface(Class.NewClass("AbsComponent"), ILifeCycle,IComponent)

function AbsComponent:Ctor(data)
    self.componentIdMgr = GenerateIdMgr.New()
    self.id = self.componentIdMgr:Next()
    self.componentData = data
    self.entity = nil
end
