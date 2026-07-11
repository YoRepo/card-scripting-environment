--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Spirit Message "I"  (ID: 31893528)
-- Type: Spell / Continuous
-- Setcode: 0x1c
-- Scope: OCG / TCG
--
-- Effect Text:
-- Can only be placed on the field by the effect of "Destiny Board".
--[[ __CARD_HEADER_END__ ]]

--死のメッセージ「E」
function c31893528.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SSET)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SPSUMMON_COST)
	e2:SetCost(c31893528.spcost)
	c:RegisterEffect(e2)
end
function c31893528.spcost(e,c,tp,sumtype)
	return sumtype==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_DARK_SANCTUARY
end
