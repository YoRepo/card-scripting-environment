--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 稀有金属龙  (ID: 25236056)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Dragon
-- Level 4
-- ATK 2400 | DEF 1200
--
-- Effect Text:
-- 这张卡不能通常召唤，用卡的效果才能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--レアメタル・ドラゴン
function c25236056.initial_effect(c)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c25236056.splimit)
	c:RegisterEffect(e1)
end
function c25236056.splimit(e,se,sp,st)
	return se:IsHasType(EFFECT_TYPE_ACTIONS)
end
