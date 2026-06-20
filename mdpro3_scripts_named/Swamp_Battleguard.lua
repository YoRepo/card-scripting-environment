--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 野蛮人2号  (ID: 40453765)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 5
-- ATK 1800 | DEF 1500
-- Setcode: 379
--
-- Effect Text:
-- ①：自己场上的「野蛮人1号」每有1只，这张卡的攻击力上升500。
--[[ __CARD_HEADER_END__ ]]

--バーバリアン2号
function c40453765.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c40453765.value)
	c:RegisterEffect(e1)
end
function c40453765.filter(c)
	return c:IsFaceup() and c:IsCode(20394040)
end
function c40453765.value(e,c)
	return Duel.GetMatchingGroupCount(c40453765.filter,c:GetControler(),LOCATION_MZONE,0,nil)*500
end
