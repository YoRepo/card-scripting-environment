--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 大革命  (ID: 65396880)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这张卡只有当处于自己的主要阶段，在自己的场上有「流离的饥民」「受弹压的民众」「团结的反抗军」表侧表示存在时才能发动。将对方的手卡全部送去墓地，将场上所有对方控制的卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--大革命
function c65396880.initial_effect(c)
	aux.AddCodeList(c,58538870,12143771,85936485)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c65396880.condition)
	e1:SetTarget(c65396880.target)
	e1:SetOperation(c65396880.activate)
	c:RegisterEffect(e1)
end
function c65396880.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c65396880.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()==tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
		and Duel.IsExistingMatchingCard(c65396880.cfilter,tp,LOCATION_ONFIELD,0,1,nil,58538870)
		and Duel.IsExistingMatchingCard(c65396880.cfilter,tp,LOCATION_ONFIELD,0,1,nil,12143771)
		and Duel.IsExistingMatchingCard(c65396880.cfilter,tp,LOCATION_ONFIELD,0,1,nil,85936485)
end
function c65396880.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil)
		or Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)~=0 end
	local g1=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,g1:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g2,g2:GetCount(),0,0)
end
function c65396880.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g1,REASON_EFFECT)
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.SendtoGrave(g2,REASON_EFFECT)
end
