--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Dicephoon  (ID: 3493058)
-- Type: Spell / Quick-Play
-- Scope: OCG / TCG
--
-- Effect Text:
-- Roll a six-sided die and apply the result.
-- ● 2, 3, or 4: Destroy 1 Spell/Trap on the field.
-- ● 5: Destroy 2 Spells/Traps on the field.
-- ● 1 or 6: You take 1000 damage.
--[[ __CARD_HEADER_END__ ]]

--サイコロン
function c3493058.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE+CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c3493058.target)
	e1:SetOperation(c3493058.activate)
	c:RegisterEffect(e1)
end
function c3493058.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c3493058.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c3493058.activate(e,tp,eg,ep,ev,re,r,rp)
	local dc=Duel.TossDice(tp,1)
	if dc==1 or dc==6 then
		Duel.Damage(tp,1000,REASON_EFFECT)
	elseif dc==5 then
		local g=Duel.GetMatchingGroup(c3493058.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,aux.ExceptThisCard(e))
		if g:GetCount()<2 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=g:Select(tp,2,2,nil)
		Duel.HintSelection(dg)
		Duel.Destroy(dg,REASON_EFFECT)
	elseif dc>=2 and dc<=4 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,c3493058.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,aux.ExceptThisCard(e))
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
