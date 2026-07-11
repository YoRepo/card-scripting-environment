--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Joruri-P.U.N.K. Madame Spider  (ID: 82041999)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Psychic
-- Level: 3
-- ATK 900 | DEF 600
-- Setcode: 0x171
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can pay 600 LP; add 1 "P.U.N.K." Trap from your Deck to your hand.
-- When you activate a "P.U.N.K." card or effect that targets a card your opponent controls (except
-- during the Damage Step) (Quick Effect): You can target 1 face-up monster your opponent controls; its
-- ATK becomes halved until the end of this turn.
-- You can only use each effect of "Joruri-P.U.N.K. Madame Spider" once per turn.
--[[ __CARD_HEADER_END__ ]]

--Jo－P.U.N.K.Mme.スパイダー
function c82041999.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82041999,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,82041999)
	e1:SetCost(c82041999.thcost)
	e1:SetTarget(c82041999.thtg)
	e1:SetOperation(c82041999.thop)
	c:RegisterEffect(e1)
	--half atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(82041999,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_BECOME_TARGET)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,82042000)
	e2:SetCondition(c82041999.atkcon)
	e2:SetTarget(c82041999.atktg)
	e2:SetOperation(c82041999.atkop)
	c:RegisterEffect(e2)
end
function c82041999.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,600) end
	Duel.PayLPCost(tp,600)
end
function c82041999.thfilter(c)
	return c:IsSetCard(0x171) and c:IsType(TYPE_TRAP) and c:IsAbleToHand()
end
function c82041999.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c82041999.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c82041999.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c82041999.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c82041999.cfilter(c,tp)
	return c:IsControler(1-tp) and c:IsOnField()
end
function c82041999.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==tp and re:GetHandler():IsSetCard(0x171) and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
		and eg:IsExists(c82041999.cfilter,1,nil,tp)
end
function c82041999.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c82041999.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(math.ceil(tc:GetAttack()/2))
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
