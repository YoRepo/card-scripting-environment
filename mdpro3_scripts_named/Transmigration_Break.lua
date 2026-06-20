--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 转生断绝  (ID: 66100045)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 从墓地回到卡组的卡不回到卡组从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--転生断絶
function c66100045.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_GRAVE,LOCATION_GRAVE)
	e2:SetCode(EFFECT_TO_DECK_REDIRECT)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
end
