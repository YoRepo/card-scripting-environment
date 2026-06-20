--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 光之追放者  (ID: 61528025)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 3
-- ATK 100 | DEF 2000
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，被送去墓地的卡不去墓地从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--光の追放者
function c61528025.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_DECK,LOCATION_DECK)
	e1:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e1)
end
