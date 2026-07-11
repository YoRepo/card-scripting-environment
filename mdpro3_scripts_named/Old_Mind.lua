--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Old Mind  (ID: 54239282)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Look at 1 random card in your opponent's hand, then apply 1 of the following effects.
-- ● Discard both that opponent's card and 1 card from your hand of the same type (Monster, Spell, or
-- Trap), then add this card from the field to your opponent's hand, and if you do, draw 1 card.
-- ● Lose 1000 LP.
-- You can only activate 1 "Old Mind" per turn.
--[[ __CARD_HEADER_END__ ]]

--オールド・マインド
function c54239282.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_HANDES_SELF+CATEGORY_HANDES_OPPO)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,54239282+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c54239282.target)
	e1:SetOperation(c54239282.activate)
	c:RegisterEffect(e1)
end
function c54239282.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)>0 end
end
function c54239282.filter(c,type)
	return c:IsType(type) and c:IsDiscardable(REASON_EFFECT)
end
function c54239282.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)==0 then return end
	local g=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0):RandomSelect(tp,1)
	local tc=g:GetFirst()
	Duel.ConfirmCards(tp,tc)
	local type=bit.band(tc:GetType(),0x7)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c54239282.filter,tp,LOCATION_HAND,0,nil,type)
	local op=0
	if g:GetCount()>0 and tc:IsDiscardable(REASON_EFFECT) and c:IsRelateToEffect(e) and c:GetLeaveFieldDest()==0 and Duel.IsPlayerCanDraw(tp,1) then
		op=Duel.SelectOption(tp,aux.Stringid(54239282,0),aux.Stringid(54239282,1))
	else
		op=Duel.SelectOption(tp,aux.Stringid(54239282,1))+1
	end
	if op==0 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
		local sg=g:Select(tp,1,1,nil)
		sg:AddCard(tc)
		if Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)~=0 and c:IsRelateToEffect(e) then
			Duel.BreakEffect()
			c:CancelToGrave()
			if Duel.SendtoHand(c,1-tp,REASON_EFFECT)~=0 then
				Duel.Draw(tp,1,REASON_EFFECT)
			end
		end
	else
		Duel.BreakEffect()
		Duel.SetLP(tp,Duel.GetLP(tp)-1000)
		Duel.ShuffleHand(1-tp)
	end
end
