--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Amazoness Chain Master  (ID: 29654737)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 1500 | DEF 1300
-- Setcode: 0x4
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is destroyed by battle and sent to the GY: You can pay 1500 LP; look at your
-- opponent's hand, then add 1 monster from their hand to your hand.
--[[ __CARD_HEADER_END__ ]]

--アマゾネスの鎖使い
function c29654737.initial_effect(c)
	--get card
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29654737,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c29654737.condition)
	e1:SetCost(c29654737.cost)
	e1:SetOperation(c29654737.operation)
	c:RegisterEffect(e1)
end
function c29654737.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
		and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)~=0
end
function c29654737.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1500) end
	Duel.PayLPCost(tp,1500)
end
function c29654737.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		local tg=g:Filter(Card.IsType,nil,TYPE_MONSTER)
		if tg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=tg:Select(tp,1,1,nil)
			Duel.SendtoHand(sg,tp,REASON_EFFECT)
		end
		Duel.ShuffleHand(1-tp)
	end
end
