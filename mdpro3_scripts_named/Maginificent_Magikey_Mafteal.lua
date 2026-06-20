--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 大魔键-马夫提亚尔  (ID: 15983048)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Fiend
-- Level 4
-- ATK 1600 | DEF 1600
-- Setcode: 357
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次，把这张卡作为同调·超量召唤的素材的场合，不是「魔键」怪兽的同调·超量召唤不能使用。
-- ①：自己场上有「魔键」怪兽存在的场合，把手卡的这张卡给对方观看才能发动。这个回合，自己在通常召唤外加上只有1次，可以把1只「魔键」怪兽召唤。
-- ②：这张卡召唤成功时，以自己墓地的4星以下的1只通常怪兽或者「魔键」怪兽为对象才能发动。那只怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--大魔鍵－マフテアル
function c15983048.initial_effect(c)
	--synchro and xyz limit
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetValue(c15983048.matlimit)
	c:RegisterEffect(e0)
	local e1=e0:Clone()
	e1:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(15983048,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c15983048.condition)
	e2:SetCost(c15983048.cost)
	e2:SetTarget(c15983048.target)
	e2:SetOperation(c15983048.operation)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(15983048,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCountLimit(1,15983048)
	e3:SetTarget(c15983048.sptg)
	e3:SetOperation(c15983048.spop)
	c:RegisterEffect(e3)
end
function c15983048.matlimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x165)
end
function c15983048.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x165)
end
function c15983048.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c15983048.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c15983048.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function c15983048.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSummon(tp) and Duel.IsPlayerCanAdditionalSummon(tp)
		and Duel.GetFlagEffect(tp,15983048)==0 end
end
function c15983048.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(15983048,2))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x165))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,15983048,RESET_PHASE+PHASE_END,0,1)
end
function c15983048.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and (c:IsType(TYPE_NORMAL) or c:IsSetCard(0x165))
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c15983048.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c15983048.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c15983048.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c15983048.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c15983048.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
