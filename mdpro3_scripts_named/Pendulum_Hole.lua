--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 灵摆洞  (ID: 68477598)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 15859849
--
-- Effect Text:
-- ①：自己或者对方把怪兽灵摆召唤之际才能发动。那次灵摆召唤无效，那些怪兽回到持有者卡组。
--[[ __CARD_HEADER_END__ ]]

--ペンデュラム・ホール
function c68477598.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c68477598.condition)
	e1:SetTarget(c68477598.target)
	e1:SetOperation(c68477598.activate)
	c:RegisterEffect(e1)
end
function c68477598.cfilter(c)
	return c:IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c68477598.condition(e,tp,eg,ep,ev,re,r,rp)
	return aux.NegateSummonCondition() and eg:IsExists(c68477598.cfilter,1,nil)
end
function c68477598.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,eg:GetCount(),0,0)
end
function c68477598.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.SendtoDeck(eg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
