--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Good & Evil in the Burning Abyss  (ID: 62835876)
-- Type: Spell / Ritual
-- Setcode: 0xb1
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Malacoda, Netherlord of the Burning Abyss".
-- You must also Tribute monsters from your hand or field whose total Levels equal 6 or more.
-- During your Main Phase, except the turn this card was sent to the Graveyard: You can banish this
-- card from your Graveyard and send 1 "Burning Abyss" monster from your hand to the Graveyard; add 1
-- "Burning Abyss" card from your Deck to your hand.
-- You can only use this effect of "Good & Evil in the Burning Abyss" once per turn.
--[[ __CARD_HEADER_END__ ]]

--善悪の彼岸
function c62835876.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,35330871)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,62835876)
	e1:SetCondition(aux.exccon)
	e1:SetCost(c62835876.thcost)
	e1:SetTarget(c62835876.thtg)
	e1:SetOperation(c62835876.thop)
	c:RegisterEffect(e1)
end
function c62835876.cfilter(c)
	return c:IsSetCard(0xb1) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c62835876.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c62835876.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
	Duel.DiscardHand(tp,c62835876.cfilter,1,1,REASON_COST,nil)
end
function c62835876.filter(c)
	return c:IsSetCard(0xb1) and c:IsAbleToHand()
end
function c62835876.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c62835876.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c62835876.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c62835876.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
