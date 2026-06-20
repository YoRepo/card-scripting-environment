--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 调整魔术师  (ID: 47459126)
-- Type: Monster / Effect / Gemini
-- Attribute: WIND
-- Race: Spellcaster
-- Level 4
-- ATK 1800 | DEF 1600
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。场上表侧表示存在的这张卡可以作当成通常召唤使用的再度召唤，这张卡变成当作效果怪兽使用并得到以下效果。
-- ●只要这张卡在场上表侧表示存在，这张卡当作调整使用。
--[[ __CARD_HEADER_END__ ]]

--チューンド・マジシャン
function c47459126.initial_effect(c)
	aux.EnableDualAttribute(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_TYPE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.IsDualState)
	e1:SetValue(TYPE_TUNER)
	c:RegisterEffect(e1)
end
c47459126.treat_itself_tuner=true
