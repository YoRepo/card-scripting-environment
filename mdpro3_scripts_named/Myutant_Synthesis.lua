--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Myutant Synthesis  (ID: 79194594)
-- Type: Monster / Effect / Fusion
-- Attribute: WATER
-- Race: Psychic
-- Level: 9
-- ATK 2500 | DEF 2000
-- Setcode: 0x157
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 "Myutant" monsters with different Attributes
-- If this card is Fusion Summoned: You can target 1 card on the field; destroy it.
-- When your opponent activates a card or effect (Quick Effect): You can activate this effect; for the
-- rest of this turn, this face-up card is unaffected by the effects of an opponent's cards of the same
-- type (Monster, Spell, or Trap) as that card.
-- If this Fusion Summoned card you control is destroyed by an opponent's card: You can add 1 of your
-- banished "Myutant" cards to your hand.
-- You can only use each effect of "Myutant Synthesis" once per turn.
--[[ __CARD_HEADER_END__ ]]

--シンセシス・ミュートリアス
function c79194594.initial_effect(c)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c79194594.ffilter,2,true)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79194594,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,79194594)
	e1:SetCondition(c79194594.descon)
	e1:SetTarget(c79194594.destg)
	e1:SetOperation(c79194594.desop)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(79194594,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,79194595)
	e2:SetCondition(c79194594.immcon)
	e2:SetOperation(c79194594.immop)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(79194594,2))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCountLimit(1,79194596)
	e3:SetCondition(c79194594.thcon)
	e3:SetTarget(c79194594.thtg)
	e3:SetOperation(c79194594.thop)
	c:RegisterEffect(e3)
end
function c79194594.ffilter(c,fc,sub,mg,sg)
	return c:IsFusionSetCard(0x157) and (not sg or not sg:IsExists(Card.IsFusionAttribute,1,c,c:GetFusionAttribute()))
end
function c79194594.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c79194594.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c79194594.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c79194594.immcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp
end
function c79194594.immop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(c79194594.efilter)
		e1:SetLabel(re:GetActiveType())
		c:RegisterEffect(e1)
	end
end
function c79194594.efilter(e,te)
	return te:IsActiveType(e:GetLabel()) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c79194594.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsSummonType(SUMMON_TYPE_FUSION)
end
function c79194594.thfilter(c)
	return c:IsAbleToHand() and c:IsSetCard(0x157) and c:IsFaceup()
end
function c79194594.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79194594.thfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_REMOVED)
end
function c79194594.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c79194594.thfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
