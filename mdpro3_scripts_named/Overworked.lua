--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 性能过剩  (ID: 71272951)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 场上表侧表示存在的怪兽的攻击力比原本攻击力高的场合，那些怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--オーバースペック
function c71272951.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetTarget(c71272951.target)
	e1:SetOperation(c71272951.activate)
	c:RegisterEffect(e1)
end
function c71272951.filter(c)
	return c:IsFaceup() and c:GetAttack()>c:GetBaseAttack()
end
function c71272951.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c71272951.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c71272951.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c71272951.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c71272951.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
