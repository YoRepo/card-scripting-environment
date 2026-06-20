--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 废铁盗龙  (ID: 80529459)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 4
-- ATK 1400 | DEF 1000
-- Setcode: 36
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：以自己场上1只怪兽为对象才能发动。那只怪兽破坏。这个回合，自己在通常召唤外加上只有1次，自己主要阶段可以把1只「废铁」怪兽召唤。
-- ②：这张卡被「废铁」卡的效果破坏送去墓地的场合才能发动。从卡组把1张「废铁工厂」或者1只调整以外的「废铁」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--スクラップ・ラプター
function c80529459.initial_effect(c)
	aux.AddCodeList(c,28388296)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80529459,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,80529459)
	e1:SetTarget(c80529459.destg)
	e1:SetOperation(c80529459.desop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80529459,1))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,80529460)
	e2:SetCondition(c80529459.thcon)
	e2:SetTarget(c80529459.thtg)
	e2:SetOperation(c80529459.thop)
	c:RegisterEffect(e2)
end
function c80529459.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsPlayerCanSummon(tp) and Duel.IsPlayerCanAdditionalSummon(tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c80529459.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
	if Duel.IsPlayerCanSummon(tp) and Duel.IsPlayerCanAdditionalSummon(tp) and Duel.GetFlagEffect(tp,80529459)==0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(80529459,2))
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
		e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
		e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x24))
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		Duel.RegisterFlagEffect(tp,80529459,RESET_PHASE+PHASE_END,0,1)
	end
end
function c80529459.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return re and re:GetHandler():IsSetCard(0x24) and c:IsReason(REASON_EFFECT) and c:IsReason(REASON_DESTROY)
end
function c80529459.thfilter(c)
	return (c:IsCode(28388296) or not c:IsType(TYPE_TUNER) and c:IsSetCard(0x24) and c:IsType(TYPE_MONSTER)) and c:IsAbleToHand()
end
function c80529459.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80529459.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c80529459.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c80529459.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
