--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Digvorzhak, King of Heavy Industry  (ID: 29515122)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Machine
-- Rank: 5
-- ATK 3200 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 5 monsters
-- Once per turn: You can detach 1 material from this card; send the top 3 cards of your opponent's
-- Deck to the GY, then, if any monsters were sent to the GY by this effect, destroy cards your
-- opponent controls, up to the number of monsters sent.
--[[ __CARD_HEADER_END__ ]]

--重機王ドボク・ザーク
function c29515122.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,3)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29515122,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c29515122.cost)
	e1:SetTarget(c29515122.target)
	e1:SetOperation(c29515122.operation)
	c:RegisterEffect(e1)
end
function c29515122.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c29515122.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(1-tp,3) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,3)
end
function c29515122.cfilter(c)
	return c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_MONSTER)
end
function c29515122.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,3,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	local ct=g:FilterCount(c29515122.cfilter,nil)
	if ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,ct,nil)
	if dg:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.HintSelection(dg)
	Duel.Destroy(dg,REASON_EFFECT)
end
