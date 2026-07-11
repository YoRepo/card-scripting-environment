--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Goblin of Greed  (ID: 425934)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fiend
-- Level: 4
-- ATK 1000 | DEF 1800
-- Setcode: 0xac
-- Scope: OCG / TCG
--
-- Effect Text:
-- As long as this card remains face-up on your side of the field, neither player can activate an
-- effect by discarding from his/her hand.
--[[ __CARD_HEADER_END__ ]]

--強欲ゴブリン
function c425934.initial_effect(c)
	--discard limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,1)
	e1:SetCode(EFFECT_CANNOT_DISCARD_HAND)
	e1:SetTarget(c425934.target)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c425934.target(e,dc,re,r)
	return r&REASON_COST==REASON_COST
end
