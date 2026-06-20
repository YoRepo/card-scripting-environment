--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: XX排除  (ID: 31213049)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：对方把手卡的怪兽的效果发动时才能发动。那个发动无效。有对方手卡的场合，再让对方选1张手卡丢弃。
--[[ __CARD_HEADER_END__ ]]

--XXクルージョン
function c31213049.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c31213049.condition)
	e1:SetTarget(c31213049.target)
	e1:SetOperation(c31213049.activate)
	c:RegisterEffect(e1)
end
function c31213049.condition(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return ep==1-tp and loc==LOCATION_HAND and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c31213049.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 then
		Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
	end
end
function c31213049.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 then
		Duel.BreakEffect()
		Duel.DiscardHand(1-tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
	end
end
