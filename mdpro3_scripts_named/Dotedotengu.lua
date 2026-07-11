--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Dotedotengu  (ID: 82050203)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Fiend
-- Level: 3
-- ATK 0 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card in your possession is sent to your Graveyard by an opponent's card effect: You can
-- target 1 card your opponent controls; return it to the hand.
--[[ __CARD_HEADER_END__ ]]

--ドテドテング
function c82050203.initial_effect(c)
	--return
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82050203,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c82050203.retcon)
	e1:SetTarget(c82050203.rettg)
	e1:SetOperation(c82050203.retop)
	c:RegisterEffect(e1)
end
function c82050203.retcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,0x41)==0x41 and rp==1-tp and e:GetHandler():IsPreviousControler(tp)
end
function c82050203.rettg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c82050203.retop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
