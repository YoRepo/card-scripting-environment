--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 复写机块 复印小矮人  (ID: 41830887)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 331
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：以自己场上1只「机块」怪兽为对象才能发动。这张卡从手卡特殊召唤。这个效果特殊召唤的这张卡直到结束阶段当作和作为对象的怪兽同名卡使用。
-- ②：把墓地的这张卡除外，以自己场上1只「机块」怪兽为对象才能发动。从自己的手卡·墓地选1只那只怪兽的同名怪兽特殊召唤。这个效果在这张卡送去墓地的回合不能发动。
--[[ __CARD_HEADER_END__ ]]

--複写機塊コピーボックル
function c41830887.initial_effect(c)
	--Special Summon self
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41830887,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,41830887)
	e1:SetTarget(c41830887.sptg1)
	e1:SetOperation(c41830887.spop1)
	c:RegisterEffect(e1)
	--Special Summon from hand or grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(41830887,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,41830888)
	e2:SetCondition(aux.exccon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c41830887.sptg2)
	e2:SetOperation(c41830887.spop2)
	c:RegisterEffect(e2)
end
function c41830887.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x14b)
end
function c41830887.sptg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c41830887.filter(chkc) end
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c41830887.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c41830887.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c41830887.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local code=tc:GetOriginalCode()
	if not (c:IsRelateToEffect(e) and tc:IsRelateToEffect(e)) then return end
	if Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(code)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
	Duel.SpecialSummonComplete()
end
function c41830887.spfilter1(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x14b)
		and Duel.IsExistingMatchingCard(c41830887.spfilter2,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,e:GetHandler(),e,tp,c:GetCode())
end
function c41830887.spfilter2(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c41830887.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c41830887.spfilter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c41830887.spfilter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c41830887.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c41830887.spop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c41830887.spfilter2,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp,tc:GetCode())
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
