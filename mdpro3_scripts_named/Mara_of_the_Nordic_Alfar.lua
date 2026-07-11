--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Mara of the Nordic Alfar  (ID: 73417207)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 2
-- ATK 1000 | DEF 500
-- Setcode: 0xa042
-- Scope: OCG / TCG
--
-- Effect Text:
-- When using this card as Synchro Material, the other Synchro Materials must be 2 "Nordic" monsters in
-- your hand.
--[[ __CARD_HEADER_END__ ]]

--極星霊スヴァルトアールヴ
function c73417207.initial_effect(c)
	--synchro custom
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TUNER_MATERIAL_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetTarget(c73417207.synlimit)
	e1:SetTargetRange(2,2)
	e1:SetValue(LOCATION_HAND)
	c:RegisterEffect(e1)
end
function c73417207.synlimit(e,c)
	return c:IsSetCard(0x42)
end
