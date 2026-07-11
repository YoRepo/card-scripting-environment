--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: The Legendary Fisherman  (ID: 3643300)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level: 5
-- ATK 1850 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- While "Umi" is on the field, this card is unaffected by Spell effects and cannot be targeted for
-- attacks, but does not prevent your opponent from attacking you directly.
--[[ __CARD_HEADER_END__ ]]

--伝説のフィッシャーマン
function c3643300.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--immune spell
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c3643300.econ)
	e1:SetValue(c3643300.efilter)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c3643300.econ)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c3643300.econ(e)
	return Duel.IsEnvironment(22702055)
end
function c3643300.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
