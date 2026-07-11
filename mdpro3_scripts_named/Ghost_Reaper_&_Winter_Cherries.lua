--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Ghost Reaper & Winter Cherries  (ID: 62015408)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Zombie
-- Level: 3
-- ATK 0 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls more monsters than you do (Quick Effect): You can discard this card;
-- reveal 1 card in your Extra Deck, then look at your opponent's Extra Deck, also banish all cards in
-- their Extra Deck with the same name as that revealed card.
-- You can only use this effect of "Ghost Reaper & Winter Cherries" once per turn.
--[[ __CARD_HEADER_END__ ]]

--浮幽さくら
function c62015408.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCountLimit(1,62015408)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c62015408.condition)
	e1:SetCost(c62015408.cost)
	e1:SetTarget(c62015408.target)
	e1:SetOperation(c62015408.operation)
	c:RegisterEffect(e1)
end
function c62015408.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)<Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_EXTRA,0,1,nil)
end
function c62015408.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c62015408.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanRemove(tp)
		and Duel.GetFieldGroupCount(tp,LOCATION_EXTRA,0)>0
		and Duel.GetFieldGroupCount(tp,0,LOCATION_EXTRA)>0 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_EXTRA)
end
function c62015408.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local sg=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_EXTRA,0,1,1,nil)
	if sg:GetCount()>0 then
		Duel.ConfirmCards(1-tp,sg)
		Duel.BreakEffect()
		local g=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
		Duel.ConfirmCards(tp,g)
		local tg=g:Filter(Card.IsCode,nil,sg:GetFirst():GetCode())
		if tg:GetCount()>0 then
			Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
		end
		Duel.ShuffleExtra(tp)
		Duel.ShuffleExtra(1-tp)
	end
end
