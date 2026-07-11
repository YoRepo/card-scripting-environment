--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Hieracosphinx  (ID: 82260502)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 6
-- ATK 2400 | DEF 1200
-- Setcode: 0x5c
-- Scope: OCG / TCG
--
-- Effect Text:
-- Your opponent cannot select a face-down Defense Position monster as an attack target.
--[[ __CARD_HEADER_END__ ]]

--ヒエラコスフィンクス
function c82260502.initial_effect(c)
	--at limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c82260502.atlimit)
	c:RegisterEffect(e1)
end
function c82260502.atlimit(e,c)
	return c:IsPosition(POS_FACEDOWN_DEFENSE)
end
