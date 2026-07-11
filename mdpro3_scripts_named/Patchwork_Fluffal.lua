--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Patchwork Fluffal  (ID: 81481818)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level: 1
-- ATK 0 | DEF 0
-- Setcode: 0xa9
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is also treated as a "Frightfur" monster while face-up on the field.
-- This card on the field can be used as a substitute for any 1 Fusion Material whose name is
-- specifically listed on a "Frightfur" Fusion Monster, but the other Fusion Material(s) must be
-- correct.
--[[ __CARD_HEADER_END__ ]]

--パッチワーク・ファーニマル
function c81481818.initial_effect(c)
	--setcode
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(0xad)
	c:RegisterEffect(e1)
	--fusion substitute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_FUSION_SUBSTITUTE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c81481818.subval)
	c:RegisterEffect(e2)
end
function c81481818.subval(e,c)
	return c:IsSetCard(0xad)
end
