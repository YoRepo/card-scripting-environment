--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 死之信息「E」  (ID: 31893528)
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
