--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 黑羽-残夜之波刃剑鸟  (ID: 81105204)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 4
-- ATK 1900 | DEF 300
-- Setcode: 51
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次。
-- ①：自己场上有「黑羽-残夜之波刃剑鸟」以外的「黑羽」怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：场上的这张卡1回合只有1次不会被魔法·陷阱卡的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--BF－残夜のクリス
function c81105204.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,81105204+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c81105204.spcon)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetCountLimit(1)
	e2:SetValue(c81105204.valcon)
	c:RegisterEffect(e2)
end
function c81105204.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x33) and not c:IsCode(81105204)
end
function c81105204.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c81105204.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c81105204.valcon(e,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
