--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 代码导出员  (ID: 37119142)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Cyberse
-- Level 5
-- ATK 500 | DEF 2300
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：把自己场上的电子界族怪兽作为「码语者」怪兽的连接素材的场合，手卡的这张卡也能作为连接素材。
-- ②：这张卡作为「码语者」怪兽的连接素材从手卡·场上送去墓地的场合，以自己墓地1只4星以下的电子界族怪兽为对象才能发动。那只怪兽加入手卡。场上的这张卡为素材的场合可以不加入手卡把效果无效特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--コード・エクスポーター
function c37119142.initial_effect(c)
	--hand link
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_EXTRA_LINK_MATERIAL)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,37119142)
	e1:SetValue(c37119142.matval)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37119142,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCountLimit(1,37119143)
	e2:SetCondition(c37119142.thcon)
	e2:SetTarget(c37119142.thtg)
	e2:SetOperation(c37119142.thop)
	c:RegisterEffect(e2)
end
function c37119142.mfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsRace(RACE_CYBERSE) and c:IsControler(tp)
end
function c37119142.exmfilter(c)
	return c:IsLocation(LOCATION_HAND) and c:IsCode(37119142)
end
function c37119142.matval(e,lc,mg,c,tp)
	if not lc:IsSetCard(0x101) then return false,nil end
	return true,not mg or mg:IsExists(c37119142.mfilter,1,nil,tp) and not mg:IsExists(c37119142.exmfilter,1,nil)
end
function c37119142.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	e:SetLabel(0)
	if c:IsLocation(LOCATION_GRAVE) and c:IsPreviousLocation(LOCATION_ONFIELD+LOCATION_HAND) and r==REASON_LINK and c:GetReasonCard():IsSetCard(0x101) then
		if c:IsPreviousLocation(LOCATION_ONFIELD) then
			e:SetLabel(1)
			c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(37119142,1))
		end
		return true
	else
		return false
	end
end
function c37119142.thfilter(c,e,tp,chk)
	return c:IsRace(RACE_CYBERSE) and c:IsLevelBelow(4)
		and (c:IsAbleToHand() or (chk==1 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)))
end
function c37119142.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local check=e:GetLabel()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c37119142.thfilter(chkc,e,tp,check) end
	if chk==0 then return Duel.IsExistingTarget(c37119142.thfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,check) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c37119142.thfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,check)
	if e:GetLabel()==0 then
		e:SetCategory(CATEGORY_TOHAND)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	else
		e:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	end
end
function c37119142.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	if tc:IsAbleToHand()
		and (e:GetLabel()==0 or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not tc:IsCanBeSpecialSummoned(e,0,tp,false,false) or Duel.SelectOption(tp,1190,1152)==0) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	else
		if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetValue(RESET_TURN_SET)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e2)
		end
		Duel.SpecialSummonComplete()
	end
end
