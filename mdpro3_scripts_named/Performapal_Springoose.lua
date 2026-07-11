--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Performapal Springoose  (ID: 128454)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 5
-- ATK 1100 | DEF 2400
-- Setcode: 0x9f
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can banish this card from your Graveyard, then target 2 cards among the Pendulum Monsters you
-- control and/or the "Magician" and "Performapal" cards in your Pendulum Zone; return both to the
-- hand.
-- You can only use this effect of "Performapal Springoose" once per turn.
--[[ __CARD_HEADER_END__ ]]

--EMスプリングース
function c128454.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(128454,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,128454)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c128454.thtg)
	e1:SetOperation(c128454.thop)
	c:RegisterEffect(e1)
end
function c128454.thfilter(c)
	return ((c:IsLocation(LOCATION_PZONE) and c:IsSetCard(0x9f,0x98))
		or (c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsType(TYPE_PENDULUM))) and c:IsAbleToHand()
end
function c128454.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c128454.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c128454.thfilter,tp,LOCATION_ONFIELD,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c128454.thfilter,tp,LOCATION_ONFIELD,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,2,0,0)
end
function c128454.thop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()==2 then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
	end
end
