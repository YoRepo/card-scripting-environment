--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 次元要塞兵器  (ID: 1596508)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1700 | DEF 200
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，双方不能从卡组把卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--次元要塞兵器
function c1596508.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TO_GRAVE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_DECK,LOCATION_DECK)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_DISCARD_DECK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,1)
	c:RegisterEffect(e2)
end
