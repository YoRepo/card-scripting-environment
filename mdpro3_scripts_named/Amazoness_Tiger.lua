--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 亚马逊宠物虎  (ID: 10979723)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- ATK 1100 | DEF 1500
-- Setcode: 4
--
-- Effect Text:
-- ①：「亚马逊宠物虎」在自己场上只能有1只表侧表示存在。
-- ②：这张卡的攻击力上升自己场上的「亚马逊」怪兽数量×400。
-- ③：只要这张卡在怪兽区域存在，对方怪兽不能向这张卡以外的「亚马逊」怪兽攻击。
--[[ __CARD_HEADER_END__ ]]

--アマゾネスペット虎
function c10979723.initial_effect(c)
	c:SetUniqueOnField(1,0,10979723)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c10979723.val)
	c:RegisterEffect(e1)
	--at limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetValue(c10979723.atlimit)
	c:RegisterEffect(e2)
end
function c10979723.val(e,c)
	return Duel.GetMatchingGroupCount(c10979723.filter,c:GetControler(),LOCATION_MZONE,0,nil)*400
end
function c10979723.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x4)
end
function c10979723.atlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0x4) and c~=e:GetHandler()
end
