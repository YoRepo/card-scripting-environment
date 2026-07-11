--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Invader of Darkness  (ID: 56647086)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 8
-- ATK 2900 | DEF 2500
-- Scope: OCG / TCG
--
-- Effect Text:
-- Your opponent cannot activate Quick-Play Spell Cards.
--[[ __CARD_HEADER_END__ ]]

--暗黒の侵略者
function c56647086.initial_effect(c)
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c56647086.aclimit)
	c:RegisterEffect(e1)
end
function c56647086.aclimit(e,re,tp)
	return re:GetHandler():GetType()==TYPE_SPELL+TYPE_QUICKPLAY and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
