--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 朱罗纪单脊龙  (ID: 36717258)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Dinosaur
-- Level 3
-- ATK 1500 | DEF 1200
-- Setcode: 34
--
-- Effect Text:
-- ①：这张卡可以向对方怪兽全部各作1次攻击。
--[[ __CARD_HEADER_END__ ]]

--ジュラック・モノロフ
function c36717258.initial_effect(c)
	--attack all
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_ALL)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
