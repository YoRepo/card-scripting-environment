--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Tenkabito Shien  (ID: 41589166)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level: 4
-- ATK 1500 | DEF 1000
-- Setcode: 0x20
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is unaffected by the effects of Trap Cards.
--[[ __CARD_HEADER_END__ ]]

--天下人 紫炎
function c41589166.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c41589166.efilter)
	c:RegisterEffect(e1)
end
function c41589166.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP)
end
