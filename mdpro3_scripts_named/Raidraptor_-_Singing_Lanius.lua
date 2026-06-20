--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 急袭猛禽-鸣啭伯劳  (ID: 31314549)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 4
-- ATK 100 | DEF 100
-- Setcode: 186
--
-- Effect Text:
-- 「急袭猛禽-鸣啭伯劳」的①的方法的特殊召唤1回合只能有1次。
-- ①：自己场上有超量怪兽存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--RR－シンギング・レイニアス
function c31314549.initial_effect(c)
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCountLimit(1,31314549+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c31314549.spcon)
	c:RegisterEffect(e1)
end
function c31314549.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c31314549.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c31314549.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
