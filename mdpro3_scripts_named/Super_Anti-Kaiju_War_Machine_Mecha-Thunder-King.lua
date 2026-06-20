--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 对坏兽用决战兵器 机械雷鸣王  (ID: 29913783)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 9
-- ATK 2200 | DEF 2100
-- Setcode: 211
--
-- Effect Text:
-- 这个卡名的④的效果在决斗中只能使用1次。
-- ①：双方的主要阶段把这张卡从手卡丢弃才能发动。选原本持有者是对方的自己场上1只「坏兽」怪兽除外。那之后，可以从自己墓地选1只怪兽特殊召唤。
-- ②：「坏兽」怪兽在自己场上只能有1只表侧表示存在。
-- ③：场上的这张卡不受其他的「坏兽」卡的效果影响，不会被和「坏兽」怪兽的战斗破坏。
-- ④：自己结束阶段才能发动。这张卡从墓地特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--対壊獣用決戦兵器メカサンダー・キング
function c29913783.initial_effect(c)
	c:SetUniqueOnField(1,0,aux.FilterBoolFunction(Card.IsSetCard,0xd3),LOCATION_MZONE)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29913783,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCondition(c29913783.spcon)
	e1:SetCost(c29913783.spcost)
	e1:SetTarget(c29913783.sptg)
	e1:SetOperation(c29913783.spop)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c29913783.indval)
	c:RegisterEffect(e2)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetValue(c29913783.efilter)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(29913783,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCountLimit(1,29913783+EFFECT_COUNT_CODE_DUEL)
	e4:SetCondition(c29913783.spcon2)
	e4:SetTarget(c29913783.sptg2)
	e4:SetOperation(c29913783.spop2)
	c:RegisterEffect(e4)
end
function c29913783.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c29913783.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c29913783.rmfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xd3) and c:IsAbleToRemove() and c:GetOwner()==1-tp
end
function c29913783.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c29913783.rmfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_MZONE)
end
function c29913783.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function c29913783.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c29913783.rmfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	local tc=g:GetFirst()
	if tc and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0
		and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(c29913783.spfilter),tp,LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.SelectYesNo(tp,aux.Stringid(29913783,2)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c29913783.spfilter),tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c29913783.indval(e,c)
	return c:IsSetCard(0xd3)
end
function c29913783.efilter(e,te)
	return te:GetHandler():IsSetCard(0xd3)
end
function c29913783.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c29913783.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c29913783.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
