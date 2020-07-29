require('Require.Require')

--测试ECS简单系统
local EntityGourp =
{
    Fish = 1
}

--系统通过Behaviour驱动
local BattleBehaviourIns = BattleBehaviour.New()
BattleBehaviourIns:OnInit()

--添加实体对象
BattleBehaviourIns.EntityMgr:AddEntity(EntityGourp.Fish,SimpleFishEntity.New("entityDataValue"))

--查找实体对象
local entitys = BattleBehaviourIns.EntityMgr:GetEntitysByGroup(EntityGourp.Fish)
local entity = entitys[1]

--获取实体身上得组件
local com = entity:GetComponent(LookAtComponent.type)
--调用组件得方法测试
com:OnInit()
com:OnRemove()

function TestFunc1()
    -- statements
end
function TestFunc2()
    -- statements
end
local updateMgrIns = UpdateMgr.New()
updateMgrIns:RegisterFunction(TestFunc1)
updateMgrIns:RegisterFunction(TestFunc2)

local flag , id = updateMgrIns:IsRegister(TestFunc2)
print()