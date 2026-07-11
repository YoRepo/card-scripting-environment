--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Hoshiningen  (ID: 67629977)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 2
-- ATK 500 | DEF 700
-- Scope: OCG / TCG
--
-- Effect Text:
-- All LIGHT monsters on the field gain 500 ATK, also all DARK monsters on the field lose 400 ATK.
--[[ __CARD_HEADER_END__ ]]

--スーパースター
function c67629977.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(c67629977.tg1)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetTarget(c67629977.tg2)
	e2:SetValue(-400)
	c:RegisterEffect(e2)
end
function c67629977.tg1(e,c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c67629977.tg2(e,c)
	return c:IsAttribute(ATTRIBUTE_DARK)
end
