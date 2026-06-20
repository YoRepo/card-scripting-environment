--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 仪式之钟  (ID: 20228463)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 3
-- ATK 0 | DEF 1850
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，双方玩家把手卡全部持续公开。
--[[ __CARD_HEADER_END__ ]]

--セレモニーベル
function c20228463.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PUBLIC)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
	c:RegisterEffect(e1)
end
