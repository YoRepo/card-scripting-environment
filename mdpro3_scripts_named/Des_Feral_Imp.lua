--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Des Feral Imp  (ID: 81985784)
-- Type: Monster / Effect / Flip
-- Attribute: DARK
-- Race: Reptile
-- Level: 4
-- ATK 1600 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Target 1 card in your GY; shuffle that target into the Deck.
--[[ __CARD_HEADER_END__ ]]

--デスグレムリン
function c81985784.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81985784,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c81985784.target)
	e1:SetOperation(c81985784.operation)
	c:RegisterEffect(e1)
end
function c81985784.filter(c)
	return c:IsAbleToDeck()
end
function c81985784.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c81985784.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c81985784.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c81985784.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
