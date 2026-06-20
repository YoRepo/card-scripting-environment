--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 系统崩溃  (ID: 18895832)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 支付1000基本分。对方场上·墓地的机械族怪兽全部从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--システム・ダウン
function c18895832.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c18895832.cost)
	e1:SetTarget(c18895832.target)
	e1:SetOperation(c18895832.activate)
	c:RegisterEffect(e1)
end
function c18895832.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c18895832.filter(c)
	return c:IsFaceupEx() and c:IsRace(RACE_MACHINE) and c:IsAbleToRemove()
end
function c18895832.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c18895832.filter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,nil) end
	local g=Duel.GetMatchingGroup(c18895832.filter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c18895832.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c18895832.filter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
