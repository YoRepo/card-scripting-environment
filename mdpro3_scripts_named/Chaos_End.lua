--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 混沌终结  (ID: 61044390)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 207
--
-- Effect Text:
-- 当自己的卡有7张以上被除外时这张卡才能发动。破坏场上存在的所有怪兽卡。
--[[ __CARD_HEADER_END__ ]]

--カオス・エンド
function c61044390.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c61044390.condition)
	e1:SetTarget(c61044390.target)
	e1:SetOperation(c61044390.activate)
	c:RegisterEffect(e1)
end
function c61044390.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_REMOVED,0)>=7
end
function c61044390.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c61044390.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
