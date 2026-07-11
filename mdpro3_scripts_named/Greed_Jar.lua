--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Greed Jar  (ID: 76593718)
-- Type: Monster / Effect / Flip
-- Attribute: EARTH
-- Race: Rock
-- Level: 3
-- ATK 700 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Apply these effects in sequence.
-- ● Excavate any number of cards from the top of your Deck, up to the number of cards your opponent
-- controls, and if you do, add 1 of them to your hand, also send the remaining to the GY.
-- ● Send monsters from your Extra Deck to the GY, up to the number of monsters your opponent controls
-- that were Special Summoned from the Extra Deck.
-- You can only use this effect of "Greed Jar" once per turn.
--[[ __CARD_HEADER_END__ ]]

--強欲なポッド
local s,id,o=GetID()
function s.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_DECKDES+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.IsExistingMatchingCard(Card.IsSummonLocation,tp,0,LOCATION_MZONE,1,nil,LOCATION_EXTRA) then
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_EXTRA)
	end
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local dc=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if Duel.IsPlayerCanDiscardDeck(tp,1) and dc>0 then
		local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
		if dc>ct then dc=ct end
		if dc>1 then
			local t={}
			for i=1,dc do table.insert(t,i) end
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,1))
			dc=Duel.AnnounceNumber(tp,table.unpack(t))
		end
		Duel.ConfirmDecktop(tp,dc)
		local g=Duel.GetDecktopGroup(tp,dc)
		if #g>0 then
			Duel.DisableShuffleCheck()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=g:FilterSelect(tp,Card.IsAbleToHand,1,1,nil)
			if Duel.SendtoHand(sg,nil,REASON_EFFECT)>0 then
				Duel.ConfirmCards(1-tp,sg)
				Duel.ShuffleHand(tp)
				g:Sub(sg)
			end
			Duel.SendtoGrave(g,REASON_EFFECT)
		end
		Duel.BreakEffect()
	end
	local xc=Duel.GetMatchingGroupCount(Card.IsSummonLocation,tp,0,LOCATION_MZONE,nil,LOCATION_EXTRA)
	if xc>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local tg=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_EXTRA,0,1,xc,nil)
		Duel.SendtoGrave(tg,REASON_EFFECT)
	end
end
