--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Armor Ninjitsu Art of Alchemy  (ID: 16272453)
-- Type: Spell
-- Setcode: 0x61
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Ninjitsu Art" card: Destroy as many other "Ninjitsu Art" cards you control as
-- possible, then draw 2 cards.
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
