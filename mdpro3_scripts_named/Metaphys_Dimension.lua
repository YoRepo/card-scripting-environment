--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 玄化次元  (ID: 52714670)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 261
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：对方对怪兽的特殊召唤成功的场合，以除外的1只自己的「玄化」怪兽为对象才能把这个效果发动。那只怪兽特殊召唤。这个效果特殊召唤的怪兽在下个回合的结束阶段除外。
-- ②：这张卡已在魔法与陷阱区域存在的状态，这张卡以外的自己的「玄化」卡被除外的场合，以对方场上1张卡为对象才能发动。那张卡除外。
--[[ __CARD_HEADER_END__ ]]

--メタファイズ・ディメンション
function c52714670.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(52714670,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,52714670)
	e2:SetCondition(c52714670.spcon)
	e2:SetTarget(c52714670.sptg)
	e2:SetOperation(c52714670.spop)
	c:RegisterEffect(e2)
	--remove
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(52714670,2))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_REMOVE)
	e4:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1,52714671)
	e4:SetCondition(c52714670.rmcon)
	e4:SetTarget(c52714670.rmtg)
	e4:SetOperation(c52714670.rmop)
	c:RegisterEffect(e4)
end
function c52714670.cfilter(c,tp)
	return c:IsSummonPlayer(tp)
end
function c52714670.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c52714670.cfilter,1,nil,1-tp)
end
function c52714670.spfilter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x105) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c52714670.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c52714670.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c52714670.spfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c52714670.spfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c52714670.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		tc:RegisterFlagEffect(52714670,RESET_EVENT+RESETS_STANDARD,0,1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetLabel(Duel.GetTurnCount()+1)
		e2:SetLabelObject(tc)
		e2:SetCondition(c52714670.ermcon)
		e2:SetOperation(c52714670.ermop)
		Duel.RegisterEffect(e2,tp)
	end
end
function c52714670.ermcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffect(52714670)~=0 then
		return Duel.GetTurnCount()==e:GetLabel()
	else
		e:Reset()
		return false
	end
end
function c52714670.ermop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
function c52714670.rmcfilter(c,tp)
	return c:IsControler(tp) and c:IsFaceup() and c:IsSetCard(0x105) and c:IsPreviousControler(tp)
end
function c52714670.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c52714670.rmcfilter,1,e:GetHandler(),tp) and e:GetHandler():IsStatus(STATUS_EFFECT_ENABLED)
end
function c52714670.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c52714670.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
