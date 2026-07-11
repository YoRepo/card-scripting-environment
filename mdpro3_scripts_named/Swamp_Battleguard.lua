--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Swamp Battleguard  (ID: 40453765)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 5
-- ATK 1800 | DEF 1500
-- Setcode: 0x17b
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains 500 ATK for each "Lava Battleguard" you control.
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
