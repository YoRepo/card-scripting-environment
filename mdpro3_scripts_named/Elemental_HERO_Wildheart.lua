--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 元素英雄 荒野侠  (ID: 86188410)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1500 | DEF 1600
-- Setcode: 12296
--
-- Effect Text:
-- ①：这张卡只要在怪兽区域存在，不受陷阱卡的效果影响。
--[[ __CARD_HEADER_END__ ]]

--E・HERO ワイルドマン
function c86188410.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c86188410.efilter)
	c:RegisterEffect(e1)
end
function c86188410.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP)
end
