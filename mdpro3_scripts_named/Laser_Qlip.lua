--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 机壳的要塞  (ID: 43034264)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 170
--
-- Effect Text:
-- ①：只要这张卡在场地区域存在，自己在通常召唤外加上只有1次，自己主要阶段可以把1只「机壳」怪兽召唤。
-- ②：只要这张卡在场地区域存在，「机壳」怪兽的召唤不会被无效化。
--[[ __CARD_HEADER_END__ ]]

--機殻の要塞
function c43034264.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(43034264,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xaa))
	c:RegisterEffect(e2)
	--cannot disable summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e3:SetRange(LOCATION_FZONE)
	e3:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xaa))
	c:RegisterEffect(e3)
end
