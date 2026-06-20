--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 骰子旋风  (ID: 3493058)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：掷1次骰子，出现的数目的效果适用。
-- ●2·3·4：选场上1张魔法·陷阱卡破坏。
-- ●5：选场上2张魔法·陷阱卡破坏。
-- ●1·6：自己受到1000伤害。
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
