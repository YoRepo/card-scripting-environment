--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 半月龙 半径龙  (ID: 6483224)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 4
-- ATK 1400 | DEF 1200
--
-- Effect Text:
-- 对方场上有超量怪兽存在的场合，这张卡可以从手卡特殊召唤。这个方法特殊召唤的这张卡的等级变成8星。
--[[ __CARD_HEADER_END__ ]]

--半月竜ラディウス
function c6483224.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetCondition(c6483224.spcon)
	e1:SetOperation(c6483224.spop)
	c:RegisterEffect(e1)
end
function c6483224.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c6483224.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c6483224.filter,c:GetControler(),0,LOCATION_MZONE,1,nil)
end
function c6483224.spop(e,tp,eg,ep,ev,re,r,rp,c)
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetValue(8)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
