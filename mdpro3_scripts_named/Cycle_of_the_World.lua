--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Cycle of the World  (ID: 32828635)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Ruin, Queen of Oblivion" or "Demise, King of Armageddon".
-- You must also Tribute monsters from your field whose total Levels equal or exceed the Level of the
-- Ritual Monster you Ritual Summon.
-- During your Main Phase, except the turn this card was sent to the GY: You can shuffle this card into
-- the Deck; add 1 "End of the World" from your Deck to your hand, then, you can add 1 "Ruin, Queen of
-- Oblivion" or "Demise, King of Armageddon" from your GY to your hand.
--[[ __CARD_HEADER_END__ ]]

--エンドレス・オブ・ザ・ワールド
function c32828635.initial_effect(c)
	aux.AddCodeList(c,8198712,46427957,72426662)
	aux.AddRitualProcGreater2Code2(c,46427957,72426662,nil,nil,c32828635.mfilter)
	--salvage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32828635,0))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(aux.exccon)
	e2:SetCost(c32828635.thcost)
	e2:SetTarget(c32828635.thtg)
	e2:SetOperation(c32828635.thop)
	c:RegisterEffect(e2)
end
function c32828635.mfilter(c)
	return not c:IsLocation(LOCATION_HAND)
end
function c32828635.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,SEQ_DECKSHUFFLE,REASON_COST)
end
function c32828635.filter(c)
	return c:IsCode(8198712) and c:IsAbleToHand()
end
function c32828635.filter2(c)
	return c:IsCode(46427957,72426662) and c:IsAbleToHand()
end
function c32828635.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c32828635.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c32828635.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c32828635.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		local mg=Duel.GetMatchingGroup(aux.NecroValleyFilter(c32828635.filter2),tp,LOCATION_GRAVE,0,nil)
		if mg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(32828635,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=mg:Select(tp,1,1,nil)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
