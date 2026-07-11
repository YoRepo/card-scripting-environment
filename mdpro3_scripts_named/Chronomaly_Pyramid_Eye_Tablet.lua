--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Chronomaly Pyramid Eye Tablet  (ID: 26345570)
-- Type: Spell / Continuous
-- Setcode: 0x70
-- Scope: OCG / TCG
--
-- Effect Text:
-- All "Chronomaly" monsters you control gain 800 ATK.
--[[ __CARD_HEADER_END__ ]]

--先史遺産－ピラミッド・アイ・タブレット
function c26345570.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x70))
	e2:SetValue(800)
	c:RegisterEffect(e2)
end
