--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 虚无魔人  (ID: 47084486)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 6
-- ATK 2400 | DEF 1200
--
-- Effect Text:
-- 这张卡不能特殊召唤。
-- ①：只要这张卡在怪兽区域存在，双方不能把怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--虚無魔人
function c47084486.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--disable spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	c:RegisterEffect(e2)
end
