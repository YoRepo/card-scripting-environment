--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 幻水龙  (ID: 92841002)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Dragon
-- Level 8
-- ATK 1000 | DEF 2000
--
-- Effect Text:
-- 自己场上有地属性怪兽存在的场合，这张卡可以从手卡特殊召唤。这个方法的「幻水龙」的特殊召唤1回合只能有1次。
--[[ __CARD_HEADER_END__ ]]

--幻水龍
function c92841002.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,92841002+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c92841002.spcon)
	c:RegisterEffect(e1)
end
function c92841002.spfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_EARTH)
end
function c92841002.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c92841002.spfilter,tp,LOCATION_MZONE,0,1,nil)
end
