--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Berserker Soul  (ID: 15381252)
-- Type: Spell / Quick-Play
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a monster you control inflicts 1500 or less damage to your opponent by a direct attack: Discard
-- your entire hand (min. 1); excavate the top card of your Deck, and if it is a Monster Card, send it
-- to the GY, and if you do that, inflict 500 damage to your opponent, then repeat this effect up to 7
-- more times or until you excavate a non-Monster Card.
-- If a non-Monster Card is excavated, place it on the top of your Deck.
-- You can only activate 1 "Berserker Soul" per turn.
--[[ __CARD_HEADER_END__ ]]

--狂戦士の魂
function c15381252.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCountLimit(1,15381252+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c15381252.condition)
	e1:SetCost(c15381252.cost)
	e1:SetTarget(c15381252.target)
	e1:SetOperation(c15381252.activate)
	c:RegisterEffect(e1)
end
function c15381252.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and eg:GetFirst():GetControler()==tp and ev<=1500 and Duel.GetAttackTarget()==nil
end
function c15381252.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		g:RemoveCard(e:GetHandler())
		return g:GetCount()>0 and g:FilterCount(Card.IsDiscardable,nil)==g:GetCount()
	end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
end
function c15381252.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c15381252.activate(e,tp,eg,ep,ev,re,r,rp)
	local count=8
	while count>0 and Duel.IsPlayerCanDiscardDeck(tp,1) and Duel.GetLP(1-tp)>0 do
		if count<8 then Duel.BreakEffect() end
		Duel.ConfirmDecktop(tp,1)
		local g=Duel.GetDecktopGroup(tp,1)
		local tc=g:GetFirst()
		if tc:IsType(TYPE_MONSTER) then
			Duel.DisableShuffleCheck()
			Duel.SendtoGrave(tc,REASON_EFFECT+REASON_REVEAL)
			if tc:IsLocation(LOCATION_GRAVE) then
				Duel.Damage(1-tp,500,REASON_EFFECT)
				count=count-1
			else count=0 end
		else
			count=0
		end
	end
end
