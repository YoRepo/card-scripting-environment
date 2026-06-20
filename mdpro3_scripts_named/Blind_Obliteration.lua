--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 无差别崩坏  (ID: 22802010)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：掷2次骰子。等级·阶级比出现的数目合计低的场上的表侧表示怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--無差別崩壊
function c22802010.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DICE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c22802010.target)
	e1:SetOperation(c22802010.activate)
	c:RegisterEffect(e1)
end
function c22802010.filter(c,lv)
	return c:IsFaceup() and (c:IsLevelBelow(lv) or c:IsRankBelow(lv))
end
function c22802010.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c22802010.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,11) end
	local g=Duel.GetMatchingGroup(c22802010.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,1)
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c22802010.activate(e,tp,eg,ep,ev,re,r,rp)
	local d1,d2=Duel.TossDice(tp,2)
	local g=Duel.GetMatchingGroup(c22802010.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,d1+d2-1)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
