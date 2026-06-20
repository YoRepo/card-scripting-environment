--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 下位恶魔  (ID: 16475472)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 5
-- ATK 2100 | DEF 1000
-- Setcode: 69
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，这张卡战斗破坏的怪兽不送去墓地从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--レッサー・デーモン
function c16475472.initial_effect(c)
	--redirect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_BATTLE_DESTROY_REDIRECT)
	e1:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e1)
end
