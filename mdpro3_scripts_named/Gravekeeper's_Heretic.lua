--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Gravekeeper's Heretic  (ID: 46955770)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 4
-- ATK 1800 | DEF 1500
-- Setcode: 0x2e
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card on the field is unaffected by all other card effects, as long as "Necrovalley" is also on
-- the field.
--[[ __CARD_HEADER_END__ ]]

--墓守の異端者
function c46955770.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetCondition(c46955770.con)
	e1:SetValue(c46955770.efilter)
	c:RegisterEffect(e1)
end
function c46955770.con(e)
	return Duel.IsEnvironment(47355498)
end
function c46955770.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
