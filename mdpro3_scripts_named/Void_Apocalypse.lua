--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Void Apocalypse  (ID: 7337976)
-- Type: Spell / Continuous
-- Setcode: 0xc5
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can discard 1 card; send 1 Fiend monster from your Deck to the GY.
-- You can send this face-up card from your Spell & Trap Zone to the GY; send "Infernoid" monsters with
-- different names from your hand and/or Deck to the GY, up to the number of monsters your opponent
-- controls that were Special Summoned from the Extra Deck.
-- You can only use 1 "Void Apocalypse" effect per turn, and only once that turn.
--[[ __CARD_HEADER_END__ ]]

--煉獄の災天
function c7337976.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--to grave1
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(7337976,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,7337976)
	e2:SetCost(c7337976.tgcost1)
	e2:SetTarget(c7337976.tgtg1)
	e2:SetOperation(c7337976.tgop1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetDescription(aux.Stringid(7337976,1))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetCost(c7337976.tgcost2)
	e3:SetTarget(c7337976.tgtg2)
	e3:SetOperation(c7337976.tgop2)
	c:RegisterEffect(e3)
end
function c7337976.tgcost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.SelectMatchingCard(tp,Card.IsDiscardable,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
end
function c7337976.filter1(c)
	return c:IsRace(RACE_FIEND) and c:IsAbleToGrave()
end
function c7337976.tgtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c7337976.filter1,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c7337976.tgop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c7337976.filter1,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c7337976.tgcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c7337976.filter2(c)
	return c:IsSetCard(0xbb) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c7337976.exfilter(c)
	return c:IsSummonLocation(LOCATION_EXTRA)
end
function c7337976.tgtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c7337976.exfilter,tp,0,LOCATION_MZONE,nil)
	local g=Duel.GetMatchingGroup(c7337976.filter2,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
	if chk==0 then return ct>0 and g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c7337976.tgop2(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c7337976.exfilter,tp,0,LOCATION_MZONE,nil)
	if ct<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.GetMatchingGroup(c7337976.filter2,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
	aux.GCheckAdditional=aux.dncheck
	local sg=g:SelectSubGroup(tp,aux.TRUE,false,1,ct)
	aux.GCheckAdditional=nil
	if sg:GetCount()>0 then
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end
