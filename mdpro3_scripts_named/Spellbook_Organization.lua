--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Spellbook Organization  (ID: 96677818)
-- Type: Spell / Quick-Play
-- Setcode: 0x106e
-- Scope: OCG / TCG
--
-- Effect Text:
-- Look at the top 3 cards of your Deck, then return them to the top of the Deck in any order.
--[[ __CARD_HEADER_END__ ]]

--魔導書整理
function c96677818.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c96677818.target)
	e1:SetOperation(c96677818.activate)
	c:RegisterEffect(e1)
end
function c96677818.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>2 end
end
function c96677818.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,tp,3)
end
