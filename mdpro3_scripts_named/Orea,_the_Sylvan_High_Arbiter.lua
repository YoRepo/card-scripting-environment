--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Orea, the Sylvan High Arbiter  (ID: 95239444)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Plant
-- Rank: 7
-- ATK 2800 | DEF 2500
-- Setcode: 0x90
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 7 monsters
-- Once per turn: You can send 1 Plant-Type monster from your hand or face-up from your side of the
-- field to the Graveyard; look at a number of cards from the top of your Deck equal to the Level that
-- the sent monster had in the hand or on the field, then place them on the top of the Deck in any
-- order.
-- Once per turn: You can detach 1 Xyz Material from this card; choose a number from 1 to 3, then
-- excavate that many cards from the top of your Deck, send any excavated Plant-Type monsters to the
-- Graveyard, and if you do, return up to that many cards on the field to the hand (min. 1), except
-- this card.
-- Also, place the other cards on the bottom of your Deck in any order.
--[[ __CARD_HEADER_END__ ]]

--森羅の鎮神 オレイア
function c95239444.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,2)
	c:EnableReviveLimit()
	--sort
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95239444,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c95239444.stcost)
	e1:SetOperation(c95239444.stop)
	c:RegisterEffect(e1)
	--tograve
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95239444,1))
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c95239444.cost)
	e2:SetTarget(c95239444.target)
	e2:SetOperation(c95239444.operation)
	c:RegisterEffect(e2)
end
function c95239444.cfilter(c,lv)
	return c:IsRace(RACE_PLANT) and c:IsLevelBelow(lv) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsAbleToGraveAsCost()
end
function c95239444.stcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if chk==0 then return Duel.IsExistingMatchingCard(c95239444.cfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,nil,ct) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c95239444.cfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,1,nil,ct)
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabel(Duel.GetOperatedGroup():GetFirst():GetLevel())
end
function c95239444.stop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,tp,e:GetLabel())
end
function c95239444.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c95239444.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1)
		and Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
end
function c95239444.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct==0 then return end
	if ct>3 then ct=3 end
	local t={}
	for i=1,ct do t[i]=i end
	local ac=Duel.AnnounceNumber(tp,table.unpack(t))
	Duel.ConfirmDecktop(tp,ac)
	local g=Duel.GetDecktopGroup(tp,ac)
	local sg=g:Filter(Card.IsRace,nil,RACE_PLANT)
	Duel.DisableShuffleCheck()
	if Duel.SendtoGrave(sg,REASON_EFFECT+REASON_REVEAL)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local tg=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,sg:GetCount(),c)
		if tg:GetCount()>0 then
			Duel.DisableShuffleCheck(false)
			Duel.SendtoHand(tg,nil,REASON_EFFECT)
		end
	end
	ac=ac-sg:GetCount()
	if ac>0 then
		Duel.SortDecktop(tp,tp,ac)
		for i=1,ac do
			local mg=Duel.GetDecktopGroup(tp,1)
			Duel.MoveSequence(mg:GetFirst(),SEQ_DECKBOTTOM)
		end
	end
end
