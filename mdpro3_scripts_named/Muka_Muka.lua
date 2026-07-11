--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Muka Muka  (ID: 46657337)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 2
-- ATK 600 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains 300 ATK/DEF for each card in your hand.
--[[ __CARD_HEADER_END__ ]]

--ムカムカ
function c46657337.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c46657337.val)
	c:RegisterEffect(e1)
	--defup
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
function c46657337.val(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)*300
end
