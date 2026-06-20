--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 垃圾王  (ID: 44682448)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 5
-- ATK 0 | DEF 2400
--
-- Effect Text:
-- 这张卡可以支付2000基本分，从手卡特殊召唤。把这张卡作为超量素材的场合，不是暗属性怪兽的超量召唤不能使用。
--[[ __CARD_HEADER_END__ ]]

--ガーベージ・ロード
function c44682448.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c44682448.spcon)
	e1:SetOperation(c44682448.spop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e2:SetValue(c44682448.xyzlimit)
	c:RegisterEffect(e2)
end
function c44682448.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.CheckLPCost(c:GetControler(),2000)
end
function c44682448.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.PayLPCost(tp,2000)
end
function c44682448.xyzlimit(e,c)
	if not c then return false end
	return not c:IsAttribute(ATTRIBUTE_DARK)
end
