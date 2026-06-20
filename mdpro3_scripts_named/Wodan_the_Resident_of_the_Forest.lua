--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 森之住人 乌丹  (ID: 42883273)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 3
-- ATK 900 | DEF 1200
--
-- Effect Text:
-- 场上每存在1只表侧表示的植物族怪兽，这张卡的攻击力上升100。
--[[ __CARD_HEADER_END__ ]]

--森の住人 ウダン
function c42883273.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c42883273.value)
	c:RegisterEffect(e1)
end
function c42883273.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c42883273.value(e,c)
	return Duel.GetMatchingGroupCount(c42883273.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)*100
end
