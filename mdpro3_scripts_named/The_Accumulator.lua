--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: The Accumulator  (ID: 70410002)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 1
-- ATK 0 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains ATK equal to the combined Link Ratings of all Link Monsters on the field x 300.
--[[ __CARD_HEADER_END__ ]]

--ザ・アキュムレーター
function c70410002.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c70410002.atkval)
	c:RegisterEffect(e1)
end
function c70410002.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_LINK)
end
function c70410002.atkval(e,c)
	local g=Duel.GetMatchingGroup(c70410002.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,LOCATION_MZONE,nil)
	return g:GetSum(Card.GetLink)*300
end
