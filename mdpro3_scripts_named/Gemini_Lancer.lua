--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 二重枪兵  (ID: 26254876)
-- Type: Monster / Effect / Gemini
-- Attribute: WATER
-- Race: Sea Serpent
-- Level 4
-- ATK 1800 | DEF 1400
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。场上表侧表示存在的这张卡可以作当成通常召唤使用的再度召唤，这张卡变成当作效果怪兽使用并得到以下效果。
-- ●这张卡攻击守备表示怪兽时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--デュアル・ランサー
function c26254876.initial_effect(c)
	aux.EnableDualAttribute(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetCondition(aux.IsDualState)
	c:RegisterEffect(e1)
end
