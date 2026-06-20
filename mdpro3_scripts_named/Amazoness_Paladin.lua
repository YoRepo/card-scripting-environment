--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 亚马逊圣战士  (ID: 47480070)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1700 | DEF 300
-- Setcode: 4
--
-- Effect Text:
-- 自己场上每存在1张名称中含有「亚马逊」的怪兽卡，这张卡的攻击力上升100点。
--[[ __CARD_HEADER_END__ ]]

--アマゾネスの聖戦士
function c47480070.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c47480070.val)
	c:RegisterEffect(e1)
end
function c47480070.val(e,c)
	return Duel.GetMatchingGroupCount(c47480070.filter,c:GetControler(),LOCATION_MZONE,0,nil)*100
end
function c47480070.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x4)
end
