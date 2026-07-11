--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Tri-and-Guess  (ID: 73988674)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- If each player has an Extra Deck: Declare 1 Extra Deck monster card type (Fusion, Synchro, or Xyz);
-- both players reveal their Extra Deck, and the player who has more cards of the declared card type
-- gains 3000 Life Points.
--[[ __CARD_HEADER_END__ ]]

--三位一択
function c73988674.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c73988674.target)
	e1:SetOperation(c73988674.operation)
	c:RegisterEffect(e1)
end
function c73988674.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_EXTRA,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsFacedown,tp,0,LOCATION_EXTRA,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	local op=Duel.SelectOption(tp,aux.Stringid(73988674,0),aux.Stringid(73988674,1),aux.Stringid(73988674,2))
	e:SetLabel(op)
end
function c73988674.operation(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(tp,LOCATION_EXTRA,0)
	Duel.ConfirmCards(1-tp,g1)
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
	Duel.ConfirmCards(tp,g2)
	local tpe=0
	if e:GetLabel()==0 then tpe=TYPE_FUSION
	elseif e:GetLabel()==1 then tpe=TYPE_SYNCHRO
	else tpe=TYPE_XYZ end
	local ct1=g1:FilterCount(Card.IsType,nil,tpe)
	local ct2=g2:FilterCount(Card.IsType,nil,tpe)
	if ct1>ct2 then
		Duel.Recover(tp,3000,REASON_EFFECT)
	elseif ct1<ct2 then
		Duel.Recover(1-tp,3000,REASON_EFFECT)
	end
	Duel.ShuffleExtra(tp)
	Duel.ShuffleExtra(1-tp)
end
