--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 星圣·轩辕十四  (ID: 17129783)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level 3
-- ATK 1000 | DEF 1800
-- Setcode: 83
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，自己的主要阶段时只有1次，自己在通常召唤外加上可以把1只名字带有「星圣」的怪兽召唤。
--[[ __CARD_HEADER_END__ ]]

--セイクリッド・レオニス
function c17129783.initial_effect(c)
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17129783,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x53))
	c:RegisterEffect(e1)
end
