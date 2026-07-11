--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Spirit Message "A"  (ID: 94772232)
-- Type: Spell / Continuous
-- Setcode: 0x1c
-- Scope: OCG / TCG
--
-- Effect Text:
-- Can only be placed on the field by the effect of "Destiny Board".
--[[ __CARD_HEADER_END__ ]]

--死のメッセージ「T」
function c94772232.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SSET)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SPSUMMON_COST)
	e2:SetCost(c94772232.spcost)
	c:RegisterEffect(e2)
end
function c94772232.spcost(e,c,tp,sumtype)
	return sumtype==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_DARK_SANCTUARY
end
