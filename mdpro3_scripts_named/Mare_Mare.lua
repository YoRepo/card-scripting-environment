--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 龙落亲  (ID: 54537489)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Wyrm
-- Level 7
-- ATK 2100 | DEF 1400
--
-- Effect Text:
-- 这张卡不用幻龙族怪兽的效果不能特殊召唤。这个卡名的效果1回合可以使用最多3次。
-- ①：自己主要阶段才能发动。这张卡的等级下降1星，在自己场上把1只「龙子衍生物」（幻龙族·水·1星·攻300/守200）特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--タツノオトシオヤ
function c54537489.initial_effect(c)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c54537489.splimit)
	c:RegisterEffect(e1)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(54537489,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(3,54537489)
	e2:SetTarget(c54537489.sptg)
	e2:SetOperation(c54537489.spop)
	c:RegisterEffect(e2)
end
function c54537489.splimit(e,se,sp,st)
	return se:IsActiveType(TYPE_MONSTER) and se:GetHandler():IsRace(RACE_WYRM)
end
function c54537489.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsLevelAbove(2)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,54537490,0,TYPES_TOKEN_MONSTER,300,200,1,RACE_WYRM,ATTRIBUTE_WATER) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c54537489.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsImmuneToEffect(e) or c:IsLevel(1) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	e1:SetValue(-1)
	c:RegisterEffect(e1)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,54537490,0,TYPES_TOKEN_MONSTER,300,200,1,RACE_WYRM,ATTRIBUTE_WATER) then
		local token=Duel.CreateToken(tp,54537490)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
