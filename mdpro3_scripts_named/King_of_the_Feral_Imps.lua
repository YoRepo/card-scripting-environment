--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: King of the Feral Imps  (ID: 11398059)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Reptile
-- Rank: 4
-- ATK 2300 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 4 monsters
-- Once per turn: You can detach 1 material from this card; add 1 Reptile monster from your Deck to
-- your hand.
--[[ __CARD_HEADER_END__ ]]

--キングレムリン
function c11398059.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11398059,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c11398059.cost)
	e1:SetTarget(c11398059.target)
	e1:SetOperation(c11398059.operation)
	c:RegisterEffect(e1)
end
function c11398059.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c11398059.filter(c)
	return c:IsRace(RACE_REPTILE) and c:IsAbleToHand()
end
function c11398059.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11398059.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c11398059.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c11398059.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
