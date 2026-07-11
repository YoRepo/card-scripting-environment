--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Level Conversion Lab  (ID: 84397023)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Select 1 monster in your hand and show it to your opponent, then roll a six-sided die.
-- If the result is 1, send the selected monster to the Graveyard.
-- If the result is 2-6, the Level of the selected monster becomes equal to the result until the end of
-- this turn.
--[[ __CARD_HEADER_END__ ]]

--レベル変換実験室
function c84397023.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c84397023.tg)
	e1:SetOperation(c84397023.op)
	c:RegisterEffect(e1)
end
function c84397023.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_HAND,0,1,nil,TYPE_MONSTER) end
end
function c84397023.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_HAND,0,1,1,nil,TYPE_MONSTER)
	if g:GetCount()>0 then
		Duel.ConfirmCards(1-tp,g)
		local ct=Duel.TossDice(tp,1)
		if ct==1 then Duel.SendtoGrave(g,REASON_EFFECT)
		elseif ct>=2 and ct<=6 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetValue(ct)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END)
			g:GetFirst():RegisterEffect(e1)
			Duel.ShuffleHand(tp)
		end
	end
end
