--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 死之信息「A」  (ID: 67287533)
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

--死のメッセージ「A」
function c67287533.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SSET)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SPSUMMON_COST)
	e2:SetCost(c67287533.spcost)
	c:RegisterEffect(e2)
end
function c67287533.spcost(e,c,tp,sumtype)
	return sumtype==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_DARK_SANCTUARY
end
