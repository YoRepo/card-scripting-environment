--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 升天之黑角笛  (ID: 50323155)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：对方只把怪兽1只特殊召唤之际才能发动。那次特殊召唤无效，那只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--昇天の黒角笛
function c50323155.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c50323155.condition)
	e1:SetTarget(c50323155.target)
	e1:SetOperation(c50323155.activate)
	c:RegisterEffect(e1)
end
function c50323155.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and eg:GetCount()==1 and aux.NegateSummonCondition()
end
function c50323155.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c50323155.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
