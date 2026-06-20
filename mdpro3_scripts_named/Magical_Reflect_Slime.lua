--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 魔法史莱姆  (ID: 3918345)
-- Type: Monster / Effect / Gemini
-- Attribute: WATER
-- Race: Aqua
-- Level 3
-- ATK 700 | DEF 1200
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。场上表侧表示存在的这张卡可以作当成通常召唤使用的再度召唤，这张卡变成当作效果怪兽使用并得到以下效果。
-- ●这张卡进行战斗所受到的对控制者的战斗伤害让对方承受。
--[[ __CARD_HEADER_END__ ]]

--マジック・スライム
function c3918345.initial_effect(c)
	aux.EnableDualAttribute(c)
	--reflect battle dam
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e1:SetCondition(aux.IsDualState)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
