--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Ferret Flames  (ID: 31044787)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- If the combined ATK of all face-up monsters your opponent controls is higher than your LP: Make your
-- opponent shuffle face-up monsters they control into the Deck (their choice), except monsters with 0
-- ATK, so that the combined ATK of the remaining monsters they control becomes less than or equal to
-- your LP.
--[[ __CARD_HEADER_END__ ]]

--イタチの大暴発
function c31044787.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCondition(c31044787.condition)
	e1:SetTarget(c31044787.target)
	e1:SetOperation(c31044787.activate)
	c:RegisterEffect(e1)
end
function c31044787.filter(c,tp)
	return c:IsFaceup() and c:GetAttack()>0 and Duel.IsPlayerCanSendtoDeck(tp,c)
end
function c31044787.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c31044787.filter,tp,0,LOCATION_MZONE,nil,1-tp)
	local atk=g:GetSum(Card.GetAttack)
	return atk>Duel.GetLP(tp)
end
function c31044787.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,1-tp,LOCATION_MZONE)
end
function c31044787.getAttack(c)
	local atk=c:GetAttack()
	if atk>0xffff then atk=(atk&0x7fffffff)|0x80000000 end
	return atk
end
function c31044787.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c31044787.filter,tp,0,LOCATION_MZONE,nil,1-tp)
	local atk=g:GetSum(Card.GetAttack)
	local lp=Duel.GetLP(tp)
	local diff=atk-lp
	if diff<=0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
	local sg=g:SelectWithSumGreater(1-tp,c31044787.getAttack,diff)
	Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_RULE,1-tp)
end
