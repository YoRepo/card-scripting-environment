--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Wattkiwi  (ID: 24996659)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 3
-- ATK 600 | DEF 100
-- Setcode: 0xe
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Watt" monsters you control cannot be destroyed by battle while they are attacking.
--[[ __CARD_HEADER_END__ ]]

--エレキーウィ
function c24996659.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c24996659.indtg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c24996659.indtg(e,c)
	return c:IsSetCard(0xe) and c==Duel.GetAttacker()
end
