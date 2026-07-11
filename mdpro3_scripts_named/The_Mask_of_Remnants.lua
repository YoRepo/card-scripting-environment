--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: The Mask of Remnants  (ID: 22610082)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is activated: Shuffle this card from the field into the Deck.
-- While this card is equipped to a monster by the effect of "Masked Beast Des Gardius", take control
-- of that monster.
--[[ __CARD_HEADER_END__ ]]

--遺言の仮面
function c22610082.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c22610082.cost)
	e1:SetTarget(c22610082.target)
	e1:SetOperation(c22610082.activate)
	c:RegisterEffect(e1)
end
function c22610082.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c22610082.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 then return false end
		e:SetLabel(0)
		return e:GetHandler():IsAbleToDeck()
	end
	e:SetLabel(0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c22610082.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_EFFECT,tp,true)
	end
end
