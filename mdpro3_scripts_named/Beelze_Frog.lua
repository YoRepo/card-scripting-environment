--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 恶魔青蛙  (ID: 49522489)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 3
-- ATK 1200 | DEF 800
-- Setcode: 18
--
-- Effect Text:
-- 这张卡的攻击力上升自己墓地存在的「恶魂邪苦止」的数量×300的数值。
--[[ __CARD_HEADER_END__ ]]

--悪魔ガエル
function c49522489.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c49522489.val)
	c:RegisterEffect(e1)
end
function c49522489.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,c:GetControler(),LOCATION_GRAVE,0,nil,10456559)*300
end
