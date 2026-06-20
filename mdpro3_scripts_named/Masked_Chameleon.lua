--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 假面变色龙  (ID: 53573406)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Reptile
-- Level 4
-- ATK 1600 | DEF 1100
--
-- Effect Text:
-- 这张卡在自己场上没有5星以上的怪兽存在的场合才能召唤。这张卡的效果发动的回合，自己不用从额外卡组的特殊召唤以及这张卡的效果不能特殊召唤。
-- ①：这张卡召唤成功时，以自己墓地1只守备力0的怪兽为对象才能发动。那只怪兽守备表示特殊召唤。这个效果特殊召唤的怪兽的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--カメンレオン
function c53573406.initial_effect(c)
	--cannot summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c53573406.sumcon)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(53573406,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCost(c53573406.spcost)
	e2:SetTarget(c53573406.sptg)
	e2:SetOperation(c53573406.spop)
	c:RegisterEffect(e2)
	Duel.AddCustomActivityCounter(53573406,ACTIVITY_SPSUMMON,c53573406.counterfilter)
end
function c53573406.counterfilter(c)
	return c:IsSummonLocation(LOCATION_EXTRA)
end
function c53573406.cfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(5)
end
function c53573406.sumcon(e)
	return Duel.IsExistingMatchingCard(c53573406.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c53573406.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(53573406,tp,ACTIVITY_SPSUMMON)==0 end
	local fid=e:GetHandler():GetFieldID()
	e:SetLabel(fid)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetLabel(fid)
	e1:SetTarget(c53573406.sumlimit)
	Duel.RegisterEffect(e1,tp)
end
function c53573406.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return e:GetLabel()~=se:GetLabel() and not c:IsLocation(LOCATION_EXTRA)
end
function c53573406.filter(c,e,tp)
	return c:IsDefense(0) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c53573406.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c53573406.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c53573406.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c53573406.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c53573406.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
	end
	Duel.SpecialSummonComplete()
end
