--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Top Runner  (ID: 53623827)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Machine
-- Level: 4
-- ATK 1100 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- All face-up Synchro Monsters you control gain 600 ATK.
--[[ __CARD_HEADER_END__ ]]

--トップ・ランナー
function c53623827.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_SYNCHRO))
	e1:SetValue(600)
	c:RegisterEffect(e1)
end
