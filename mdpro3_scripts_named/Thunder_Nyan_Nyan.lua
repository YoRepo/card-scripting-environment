--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Thunder Nyan Nyan  (ID: 70797118)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 4
-- ATK 1900 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- If there is a non-LIGHT monster on your side of the field, destroy this face-up card.
--[[ __CARD_HEADER_END__ ]]

--雷電娘々
function c70797118.initial_effect(c)
	--self destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c70797118.sdcon)
	c:RegisterEffect(e1)
end
function c70797118.sdfilter(c)
	return c:IsFaceup() and c:IsNonAttribute(ATTRIBUTE_LIGHT)
end
function c70797118.sdcon(e)
	return Duel.IsExistingMatchingCard(c70797118.sdfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
