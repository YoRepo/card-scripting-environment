--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 炼狱的落穴  (ID: 1005587)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 12910668
--
-- Effect Text:
-- ①：对方把攻击力2000以上的怪兽特殊召唤时才能发动。选那1只攻击力2000以上的怪兽，把效果无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--煉獄の落とし穴
function c1005587.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c1005587.target)
	e1:SetOperation(c1005587.activate)
	c:RegisterEffect(e1)
end
function c1005587.filter(c,tp)
	return aux.NegateMonsterFilter(c) and c:IsAttackAbove(2000) and c:IsSummonPlayer(tp)
end
function c1005587.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c1005587.filter,1,nil,1-tp) end
	Duel.SetTargetCard(eg)
	local g=eg:Filter(c1005587.filter,nil,1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c1005587.filter2(c,e,tp)
	return c1005587.filter(c,tp) and c:IsRelateToEffect(e)
end
function c1005587.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c1005587.filter2,nil,e,1-tp)
	local tc=g:GetFirst()
	if not tc then return end
	if g:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		tc=g:Select(tp,1,1,nil):GetFirst()
	end
	if tc:IsCanBeDisabledByEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		Duel.AdjustInstantly()
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
