--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 解放埋伏爆发  (ID: 38777931)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己场上1只名字带有「希望皇 霍普」的怪兽解放才能发动。对方场上盖放的魔法·陷阱卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--リリース・リバース・バースト
function c38777931.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c38777931.cost)
	e1:SetTarget(c38777931.target)
	e1:SetOperation(c38777931.activate)
	c:RegisterEffect(e1)
end
function c38777931.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x107f) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x107f)
	Duel.Release(g,REASON_COST)
end
function c38777931.filter(c)
	return c:IsFacedown() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c38777931.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c38777931.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c38777931.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c38777931.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c38777931.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
