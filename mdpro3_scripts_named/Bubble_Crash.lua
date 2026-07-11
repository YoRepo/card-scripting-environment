--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Bubble Crash  (ID: 61622107)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can only be activated when any player has 6 or more cards on the field and/or in their
-- hand.
-- The player(s) then select and send cards to their respective Graveyards until the amount remaining
-- on the field and in their hand is 5.
--[[ __CARD_HEADER_END__ ]]

--バブル・クラッシュ
function c61622107.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c61622107.condition)
	e1:SetOperation(c61622107.activate)
	c:RegisterEffect(e1)
end
function c61622107.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0xe,0)>=6 or Duel.GetFieldGroupCount(tp,0,0xe)>=6
end
function c61622107.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetTurnPlayer()
	local ct=Duel.GetFieldGroupCount(p,0xe,0)
	local exc=nil
	if ct>=6 then
		if p==tp and e:IsHasType(EFFECT_TYPE_ACTIVATE) then
			exc=e:GetHandler()
		else
			exc=nil
		end
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TOGRAVE)
		local sg=Duel.SelectMatchingCard(p,nil,p,0xe,0,ct-5,ct-5,exc)
		Duel.SendtoGrave(sg,REASON_RULE)
	end
	ct=Duel.GetFieldGroupCount(1-p,0xe,0)
	if ct>=6 then
		if 1-p==tp and e:IsHasType(EFFECT_TYPE_ACTIVATE) then
			exc=e:GetHandler()
		else
			exc=nil
		end
		Duel.Hint(HINT_SELECTMSG,1-p,HINTMSG_TOGRAVE)
		local sg=Duel.SelectMatchingCard(1-p,nil,1-p,0xe,0,ct-5,ct-5,exc)
		Duel.SendtoGrave(sg,REASON_RULE)
	end
end
