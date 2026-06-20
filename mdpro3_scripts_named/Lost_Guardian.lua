--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 失落守护者  (ID: 45871897)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 4
-- ATK 100 | DEF ?
-- Setcode: 82
--
-- Effect Text:
-- 这张卡原本的守备力，是自己除外的岩石族怪兽数×700。
--[[ __CARD_HEADER_END__ ]]

--ロストガーディアン
function c45871897.initial_effect(c)
	--base defense
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_DEFENSE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c45871897.defval)
	c:RegisterEffect(e1)
end
function c45871897.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_ROCK)
end
function c45871897.defval(e,c)
	return Duel.GetMatchingGroupCount(c45871897.filter,c:GetControler(),LOCATION_REMOVED,0,nil)*700
end
