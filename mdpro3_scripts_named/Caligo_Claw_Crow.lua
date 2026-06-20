--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 乌爪鸦  (ID: 67692580)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 2
-- ATK 900 | DEF 600
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次。
-- ①：自己场上有暗属性怪兽存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--クロクロークロウ
function c67692580.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,67692580+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c67692580.spcon)
	c:RegisterEffect(e1)
end
function c67692580.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK)
end
function c67692580.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c67692580.filter,tp,LOCATION_MZONE,0,1,nil)
end
