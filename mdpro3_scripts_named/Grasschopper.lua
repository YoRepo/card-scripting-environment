--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 贵甲螳螂  (ID: 95166228)
-- Type: Monster / Effect / Gemini
-- Attribute: EARTH
-- Race: Insect
-- Level 5
-- ATK 2350 | DEF 1000
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。场上表侧表示存在的这张卡可以作当通常召唤使用的再度召唤，这张卡当作效果怪兽使用并得到以下效果。
-- ●这张卡可以向对方场上的全部怪兽各作1次攻击。
--[[ __CARD_HEADER_END__ ]]

--ヴァリュアブル・アーマー
function c95166228.initial_effect(c)
	aux.EnableDualAttribute(c)
	--attack all
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_ALL)
	e1:SetCondition(aux.IsDualState)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
