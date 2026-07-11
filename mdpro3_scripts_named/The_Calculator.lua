--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: The Calculator  (ID: 51196174)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 2
-- ATK ? | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- The ATK of this card is the combined Levels of all face-up monsters you control x 300.
--[[ __CARD_HEADER_END__ ]]

--ザ・カリキュレーター
function c51196174.initial_effect(c)
	--attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c51196174.atkval)
	c:RegisterEffect(e1)
end
function c51196174.atkval(e,c)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),LOCATION_MZONE,0,nil)
	return g:GetSum(Card.GetLevel)*300
end
