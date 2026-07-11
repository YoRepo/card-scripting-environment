--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Gishki Chain  (ID: 66399675)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Sea Serpent
-- Level: 4
-- ATK 1800 | DEF 1000
-- Setcode: 0x3a
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Normal Summoned: Look at the top 3 cards of your Deck, you can reveal 1 Ritual
-- Monster or 1 Ritual Spell Card among them and add it to your hand, also after that, place any
-- remaining cards on the top of your Deck in any order.
--[[ __CARD_HEADER_END__ ]]

--リチュア・チェイン
function c66399675.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66399675,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c66399675.operation)
	c:RegisterEffect(e1)
end
function c66399675.filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsAbleToHand()
end
function c66399675.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<3 then return end
	local g=Duel.GetDecktopGroup(tp,3)
	Duel.ConfirmCards(tp,g)
	if g:IsExists(c66399675.filter,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(66399675,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:FilterSelect(tp,c66399675.filter,1,1,nil)
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
		Duel.SortDecktop(tp,tp,2)
	else Duel.SortDecktop(tp,tp,3) end
end
