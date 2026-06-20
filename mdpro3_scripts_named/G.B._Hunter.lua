--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: G·B·猎人  (ID: 4130270)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1200 | DEF 2000
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，场上存在的卡不能回到卡组。
--[[ __CARD_HEADER_END__ ]]

--G・B・ハンター
function c4130270.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TO_DECK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsLocation,LOCATION_ONFIELD))
	c:RegisterEffect(e1)
end
