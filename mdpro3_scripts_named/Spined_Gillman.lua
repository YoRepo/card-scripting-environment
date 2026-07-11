--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Spined Gillman  (ID: 42463414)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Sea Serpent
-- Level: 3
-- ATK 1300 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- All Fish, Sea Serpent, and Aqua-Type monsters you control gain 400 ATK.
--[[ __CARD_HEADER_END__ ]]

--ニードル・ギルマン
function c42463414.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c42463414.atktg)
	e1:SetValue(400)
	c:RegisterEffect(e1)
end
function c42463414.atktg(e,c)
	return c:IsRace(0x60040)
end
