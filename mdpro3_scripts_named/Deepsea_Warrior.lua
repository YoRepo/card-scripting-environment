--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Deepsea Warrior  (ID: 24128274)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level: 5
-- ATK 1600 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- As long as "Umi" is face-up on the field, this card is unaffected by any Spell Cards.
--[[ __CARD_HEADER_END__ ]]

--深海の戦士
function c24128274.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--immune spell
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c24128274.econ)
	e1:SetValue(c24128274.efilter)
	c:RegisterEffect(e1)
end
function c24128274.econ(e)
	return Duel.IsEnvironment(22702055)
end
function c24128274.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
