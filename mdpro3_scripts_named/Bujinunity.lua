--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Bujinunity  (ID: 33611061)
-- Type: Spell
-- Setcode: 0x88
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control no other cards and have at least 1 other card in your hand: Shuffle all
-- Beast-Warrior-Type "Bujin" monsters from your Graveyard into the Deck (min. 1), and if you do, send
-- your entire hand to the Graveyard (min. 1), then you can add up to 3 Beast-Warrior-Type "Bujin"
-- monsters with different names from your Deck to your hand.
-- You can only activate 1 "Bujinunity" per turn.
--[[ __CARD_HEADER_END__ ]]

--武神集結
function c33611061.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_TOGRAVE+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,33611061+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c33611061.condition)
	e1:SetTarget(c33611061.target)
	e1:SetOperation(c33611061.activate)
	c:RegisterEffect(e1)
end
function c33611061.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(nil,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
end
function c33611061.filter(c)
	return c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR) and c:IsAbleToDeck()
end
function c33611061.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33611061.filter,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c33611061.filter,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c33611061.thfilter(c)
	return c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR) and c:IsAbleToHand()
end
function c33611061.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetMatchingGroup(c33611061.filter,tp,LOCATION_GRAVE,0,nil)
	if aux.NecroValleyNegateCheck(tg) then return end
	if tg:GetCount()>0 then
		Duel.SendtoDeck(tg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		Duel.SendtoGrave(hg,REASON_EFFECT)
		Duel.BreakEffect()
		local g=Duel.GetMatchingGroup(c33611061.thfilter,tp,LOCATION_DECK,0,nil)
		if g:GetCount()==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g1=g:SelectSubGroup(tp,aux.dncheck,false,1,3)
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
	end
end
