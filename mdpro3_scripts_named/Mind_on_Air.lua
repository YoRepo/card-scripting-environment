--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 本性暴露  (ID: 66690411)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 6
-- ATK 1000 | DEF 1600
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，对方必须永续公开手卡。
--[[ __CARD_HEADER_END__ ]]

--マインド・オン・エア
function c66690411.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PUBLIC)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_HAND)
	c:RegisterEffect(e1)
end
