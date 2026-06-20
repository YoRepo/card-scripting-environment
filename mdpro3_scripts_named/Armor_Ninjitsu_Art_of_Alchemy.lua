--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 机甲忍法 黄金变换  (ID: 16272453)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 97
--
-- Effect Text:
-- 自己场上有名字带有「忍法」的卡存在的场合才能发动。自己场上的名字带有「忍法」的卡全部破坏。那之后，从卡组抽2张卡。
--[[ __CARD_HEADER_END__ ]]

--機甲忍法ゴールド・コンバージョン
function c16272453.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c16272453.condition)
	e1:SetTarget(c16272453.target)
	e1:SetOperation(c16272453.activate)
	c:RegisterEffect(e1)
end
function c16272453.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x61)
end
function c16272453.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c16272453.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c16272453.dfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x61)
end
function c16272453.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	local g=Duel.GetMatchingGroup(c16272453.dfilter,tp,LOCATION_ONFIELD,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c16272453.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c16272453.dfilter,tp,LOCATION_ONFIELD,0,aux.ExceptThisCard(e))
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct>0 then
		Duel.BreakEffect()
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
