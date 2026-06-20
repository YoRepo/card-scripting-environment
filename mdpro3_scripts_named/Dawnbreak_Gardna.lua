--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 黎明守卫者  (ID: 57549932)
-- Type: Monster / Effect / Gemini
-- Attribute: LIGHT
-- Race: Warrior
-- Level 3
-- ATK 1500 | DEF 500
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。场上表侧表示存在的这张卡可以作当通常召唤使用的再度召唤，这张卡当作效果怪兽使用并得到以下效果。
-- ●这张卡的原本守备力变成2300。
--[[ __CARD_HEADER_END__ ]]

--サンライズ・ガードナー
function c57549932.initial_effect(c)
	aux.EnableDualAttribute(c)
	--change base defense
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.IsDualState)
	e1:SetCode(EFFECT_SET_BASE_DEFENSE)
	e1:SetValue(2300)
	c:RegisterEffect(e1)
end
