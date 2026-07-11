--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Fruits of Kozaky's Studies  (ID: 49998907)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Look at the top 3 cards of your Deck and return those cards to the top of the Deck in any order.
--[[ __CARD_HEADER_END__ ]]

--コザッキーの研究成果
function c49998907.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c49998907.target)
	e1:SetOperation(c49998907.activate)
	c:RegisterEffect(e1)
end
function c49998907.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>2 end
end
function c49998907.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,tp,3)
end
