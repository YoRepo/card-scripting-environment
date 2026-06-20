--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 地狱帝王龙  (ID: 95888876)
-- Type: Monster / Effect / Gemini
-- Attribute: FIRE
-- Race: Dragon
-- Level 6
-- ATK 2400 | DEF 1500
--
-- Effect Text:
-- ①：这张卡只要在场上·墓地存在，当作通常怪兽使用。
-- ②：可以把场上的当作通常怪兽使用的这张卡作为通常召唤作再1次召唤。那个场合，变成持有以下效果的效果怪兽。
-- ●这张卡在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--ヘルカイザー・ドラゴン
function c95888876.initial_effect(c)
	aux.EnableDualAttribute(c)
	--double atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	e1:SetCondition(aux.IsDualState)
	c:RegisterEffect(e1)
end
