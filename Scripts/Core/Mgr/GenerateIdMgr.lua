GenerateIdMgr = Class.NewClass("GenerateIdMgr")

function GenerateIdMgr:Ctor()
    self.id = 0
end

function GenerateIdMgr:Next()
    self.id = self.id + 1
    return self.id
end