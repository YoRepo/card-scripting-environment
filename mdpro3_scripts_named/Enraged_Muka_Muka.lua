--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Enraged Muka Muka  (ID: 91862578)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 5
-- ATK 1200 | DEF 600
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains 400 ATK/DEF for each card in your hand.
--[[ __CARD_HEADER_END__ ]]

--激昂のムカムカ
function c91862578.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c91862578.val)
	c:RegisterEffect(e1)
	--defup
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
function c91862578.val(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)*400
end
