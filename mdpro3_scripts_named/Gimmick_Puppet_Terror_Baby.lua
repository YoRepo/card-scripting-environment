--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 机关傀儡-恐怖婴儿  (ID: 43598843)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 500 | DEF 0
-- Setcode: 4227
--
-- Effect Text:
-- ①：这张卡召唤成功时，以「机关傀儡-恐怖婴儿」以外的自己墓地1只「机关傀儡」怪兽为对象才能发动。那只怪兽守备表示特殊召唤。
-- ②：把墓地的这张卡除外才能发动。这个回合，对方不能对应自己的「机关傀儡」怪兽的效果的发动把魔法·陷阱·怪兽的效果发动。
--[[ __CARD_HEADER_END__ ]]

--ギミック・パペット－テラー・ベビー
function c43598843.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(43598843,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c43598843.sptg)
	e1:SetOperation(c43598843.spop)
	c:RegisterEffect(e1)
	--protection
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(43598843,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	e2:SetOperation(c43598843.target)
	e2:SetOperation(c43598843.operation)
	c:RegisterEffect(e2)
end
function c43598843.spfilter(c,e,tp)
	return c:IsSetCard(0x1083) and not c:IsCode(43598843) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c43598843.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c43598843.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c43598843.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c43598843.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c43598843.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c43598843.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,43598843)==0 end
end
function c43598843.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetOperation(c43598843.actop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,43598843,RESET_PHASE+PHASE_END,0,1)
end
function c43598843.actop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if re:IsActiveType(TYPE_MONSTER) and rc:IsSetCard(0x1083) and ep==tp then
		Duel.SetChainLimit(c43598843.chainlm)
	end
end
function c43598843.chainlm(e,rp,tp)
	return tp==rp
end
