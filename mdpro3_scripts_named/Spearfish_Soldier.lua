--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 旗鱼战士  (ID: 84569017)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Sea Serpent
-- Level 4
-- ATK 1700 | DEF 1100
--
-- Effect Text:
-- 这张卡的攻击力上升从游戏中除外的自己的鱼族·海龙族·水族怪兽数量×100的数值。
--[[ __CARD_HEADER_END__ ]]

--スピアフィッシュソルジャー
function c84569017.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c84569017.atkup)
	c:RegisterEffect(e1)
end
function c84569017.atkfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FISH+RACE_AQUA+RACE_SEASERPENT)
end
function c84569017.atkup(e,c)
	return Duel.GetMatchingGroupCount(c84569017.atkfilter,c:GetControler(),LOCATION_REMOVED,0,nil)*100
end
