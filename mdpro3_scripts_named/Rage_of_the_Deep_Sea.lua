--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 深海之怒  (ID: 73778008)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 5
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这张卡的攻击力·守备力上升自己墓地存在的鱼族·海龙族·水族怪兽数量×500的数值。
--[[ __CARD_HEADER_END__ ]]

--深海の怒り
function c73778008.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c73778008.atkup)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
function c73778008.atkup(e,c)
	return Duel.GetMatchingGroupCount(Card.IsRace,c:GetControler(),LOCATION_GRAVE,0,nil,RACE_FISH+RACE_SEASERPENT+RACE_AQUA)*500
end
