--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 衰弱之雾  (ID: 26022485)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方手卡数量限制变成最多5张。
--[[ __CARD_HEADER_END__ ]]

--衰弱の霧
function c26022485.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_HAND_LIMIT)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(5)
	c:RegisterEffect(e2)
end
