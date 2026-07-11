--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Fluffal Wings  (ID: 72413000)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 1
-- ATK 100 | DEF 100
-- Setcode: 0xa9
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is in your Graveyard and you control "Toy Vendor": You can banish this card from your
-- Graveyard, then target 1 "Fluffal" monster in your Graveyard; banish it, and if you do, draw 1 card,
-- then you can send 1 "Toy Vendor" you control to the Graveyard, and if you do, draw 1 card.
-- You can only use this effect of "Fluffal Wings" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ファーニマル・ウィング
function c72413000.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,72413000)
	e1:SetCondition(c72413000.condition)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c72413000.target)
	e1:SetOperation(c72413000.operation)
	c:RegisterEffect(e1)
end
function c72413000.cfilter(c)
	return c:IsFaceup() and c:IsCode(70245411)
end
function c72413000.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c72413000.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c72413000.filter(c)
	return c:IsSetCard(0xa9) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c72413000.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c72413000.filter(chkc) end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and Duel.IsExistingTarget(c72413000.filter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c72413000.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,tp,LOCATION_GRAVE)
end
function c72413000.tgfilter(c)
	return c:IsFaceup() and c:IsCode(70245411) and c:IsAbleToGrave()
end
function c72413000.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=0
		and Duel.Draw(tp,1,REASON_EFFECT)~=0 and Duel.IsExistingMatchingCard(c72413000.tgfilter,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,aux.Stringid(72413000,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c72413000.tgfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
		if Duel.SendtoGrave(g,REASON_EFFECT)~=0 and g:GetFirst():IsLocation(LOCATION_GRAVE) then
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end
