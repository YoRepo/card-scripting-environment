--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Yu-Jo Friendship  (ID: 81332143)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Offer your opponent a handshake.
-- If they accept your handshake, each player's Life Points become half the combined Life Points of
-- both players.
-- If you have "Unity" in your hand and show it to your opponent, they must accept the handshake.
--[[ __CARD_HEADER_END__ ]]

--友情 YU－JYO
function c81332143.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c81332143.activate)
	c:RegisterEffect(e1)
end
function c81332143.activate(e,tp,eg,ep,ev,re,r,rp)
	local opt=0
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,nil,14731897) and Duel.SelectYesNo(tp,aux.Stringid(81332143,2)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_HAND,0,1,1,nil,14731897)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleHand(tp)
		opt=1
	end
	if opt==0 then
		opt=Duel.SelectOption(1-tp,aux.Stringid(81332143,0),aux.Stringid(81332143,1))
	else
		opt=Duel.SelectOption(1-tp,aux.Stringid(81332143,0))
	end
	if opt==0 then
		local lp=math.ceil((Duel.GetLP(tp)+Duel.GetLP(1-tp))/2)
		Duel.SetLP(tp,lp)
		Duel.SetLP(1-tp,lp)
	end
end
