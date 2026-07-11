--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Cannonball Spear Shellfish  (ID: 95614612)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 2
-- ATK 1000 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- While "Umi" is face-up on the field, this card is unaffected by any Spell Cards.
--[[ __CARD_HEADER_END__ ]]

--砲弾ヤリ貝
function c95614612.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--immune spell
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c95614612.econ)
	e1:SetValue(c95614612.efilter)
	c:RegisterEffect(e1)
end
function c95614612.econ(e)
	return Duel.IsEnvironment(22702055)
end
function c95614612.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
