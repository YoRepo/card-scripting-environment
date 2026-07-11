--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Earthbound Linewalker  (ID: 67987302)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 4
-- ATK 1200 | DEF 1900
-- Setcode: 0x21
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Earthbound Immortal" monsters cannot be destroyed by their own effects.
--[[ __CARD_HEADER_END__ ]]

--地縛大神官
function c67987302.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1021))
	e1:SetValue(c67987302.efilter)
	c:RegisterEffect(e1)
end
function c67987302.efilter(e,re,rp,c)
	return re:GetOwner()==c
end
