--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Pendulum Paradox  (ID: 38203732)
-- Type: Spell
-- Setcode: 0xf2
-- Scope: OCG / TCG
--
-- Effect Text:
-- Add 2 face-up Pendulum Monsters with the same Pendulum Scale, but different names, from your Extra
-- Deck to your hand.
-- You can only activate 1 "Pendulum Paradox" per turn.
--[[ __CARD_HEADER_END__ ]]

--ペンデュラム・パラドックス
function c38203732.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,38203732+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c38203732.target)
	e1:SetOperation(c38203732.activate)
	c:RegisterEffect(e1)
end
function c38203732.filter1(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
		and Duel.IsExistingMatchingCard(c38203732.filter2,tp,LOCATION_EXTRA,0,1,c,c:GetLeftScale(),c:GetCode())
end
function c38203732.filter2(c,sc,cd)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
		and c:GetLeftScale()==sc and not c:IsCode(cd)
end
function c38203732.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c38203732.filter1,tp,LOCATION_EXTRA,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_EXTRA)
end
function c38203732.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc1=Duel.SelectMatchingCard(tp,c38203732.filter1,tp,LOCATION_EXTRA,0,1,1,nil,tp):GetFirst()
	if not tc1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc2=Duel.SelectMatchingCard(tp,c38203732.filter2,tp,LOCATION_EXTRA,0,1,1,tc1,tc1:GetLeftScale(),tc1:GetCode()):GetFirst()
	Duel.SendtoHand(Group.FromCards(tc1,tc2),nil,REASON_EFFECT)
end
