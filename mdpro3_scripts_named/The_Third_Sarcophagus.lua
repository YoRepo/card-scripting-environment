--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: The Third Sarcophagus  (ID: 78697395)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can only be placed on the field by the effect of "The First Sarcophagus".
--[[ __CARD_HEADER_END__ ]]

--第三の棺
function c78697395.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SSET)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e2)
end
