--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 野蛮人1号  (ID: 20394040)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 5
-- ATK 1550 | DEF 1800
-- Setcode: 379
--
-- Effect Text:
-- ①：自己场上的「野蛮人2号」每有1只，这张卡的攻击力上升500。
--[[ __CARD_HEADER_END__ ]]

--バーバリアン1号
function c20394040.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c20394040.value)
	c:RegisterEffect(e1)
end
function c20394040.filter(c)
	return c:IsFaceup() and c:IsCode(40453765)
end
function c20394040.value(e,c)
	return Duel.GetMatchingGroupCount(c20394040.filter,c:GetControler(),LOCATION_MZONE,0,nil)*500
end
