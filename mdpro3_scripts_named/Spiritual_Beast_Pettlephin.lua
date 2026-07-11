--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Spiritual Beast Pettlephin  (ID: 13890468)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Aqua
-- Level: 4
-- ATK 0 | DEF 2000
-- Setcode: 0x20b5
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can banish 1 "Ritual Beast" card from your hand, then target 1 card your opponent
-- controls; return it to the hand.
-- You can only Special Summon "Spiritual Beast Pettlephin(s)" once per turn.
--[[ __CARD_HEADER_END__ ]]

--精霊獣 ペトルフィン
function c13890468.initial_effect(c)
	c:SetSPSummonOnce(13890468)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c13890468.cost)
	e1:SetTarget(c13890468.target)
	e1:SetOperation(c13890468.operation)
	c:RegisterEffect(e1)
end
function c13890468.filter(c)
	return c:IsSetCard(0xb5) and c:IsAbleToRemoveAsCost()
end
function c13890468.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13890468.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c13890468.filter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c13890468.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c13890468.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
