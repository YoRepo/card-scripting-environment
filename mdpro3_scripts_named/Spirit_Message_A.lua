--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 死之信息「T」  (ID: 94772232)
-- Type: Spell / Equip
-- Attribute: DARK
-- Race: Fiend
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 28
--
-- Effect Text:
-- 这张卡不用「通灵盘」的效果不能在场上出现。
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
