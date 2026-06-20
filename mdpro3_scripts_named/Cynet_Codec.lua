--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 电脑网编解码  (ID: 60018643)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 280
--
-- Effect Text:
-- 这个卡名的效果在同一连锁上只能发动1次。
-- ①：「码语者」怪兽从额外卡组往自己场上特殊召唤的场合，以那之内的1只为对象才能发动。属性和那只怪兽相同的1只电子界族怪兽从卡组加入手卡。这个回合，相同属性的怪兽不能用自己的「电脑网编解码」的效果加入手
-- 卡。这个效果的发动后，直到回合结束时自己不是电子界族怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--サイバネット・コーデック
function c60018643.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60018643,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,60018643+EFFECT_COUNT_CODE_CHAIN)
	e2:SetCondition(c60018643.thcon)
	e2:SetTarget(c60018643.thtg)
	e2:SetOperation(c60018643.thop)
	c:RegisterEffect(e2)
end
function c60018643.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x101) and c:IsControler(tp) and c:IsSummonLocation(LOCATION_EXTRA)
end
function c60018643.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c60018643.cfilter,1,nil,tp)
end
function c60018643.tgfilter(c,tp,eg)
	return eg:IsContains(c) and Duel.IsExistingMatchingCard(c60018643.thfilter,tp,LOCATION_DECK,0,1,nil,c:GetAttribute())
end
function c60018643.thfilter(c,att)
	return c:IsRace(RACE_CYBERSE) and c:IsAttribute(att) and c:IsAbleToHand()
end
function c60018643.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c60018643.tgfilter(chkc,tp,eg) end
	if chk==0 then return Duel.IsExistingTarget(c60018643.tgfilter,tp,LOCATION_MZONE,0,1,nil,tp,eg) end
	if eg:GetCount()==1 then
		Duel.SetTargetCard(eg)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		Duel.SelectTarget(tp,c60018643.tgfilter,tp,LOCATION_MZONE,0,1,1,nil,tp,eg)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c60018643.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local att=tc:GetAttribute()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c60018643.thfilter,tp,LOCATION_DECK,0,1,1,nil,att)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
			local e0=Effect.CreateEffect(c)
			e0:SetType(EFFECT_TYPE_FIELD)
			e0:SetCode(EFFECT_CANNOT_TO_HAND)
			e0:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e0:SetTargetRange(1,0)
			e0:SetTarget(c60018643.thlimit)
			e0:SetLabel(att)
			e0:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e0,tp)
		end
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c60018643.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c60018643.thlimit(e,c,tp,re)
	return c:IsAttribute(e:GetLabel()) and re and re:GetHandler():IsCode(60018643)
end
function c60018643.splimit(e,c)
	return not c:IsRace(RACE_CYBERSE) and c:IsLocation(LOCATION_EXTRA)
end
