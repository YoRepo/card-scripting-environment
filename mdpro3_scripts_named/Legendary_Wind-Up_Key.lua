--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 传说的发条  (ID: 69320362)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 88
--
-- Effect Text:
-- 自己场上表侧表示存在的名字带有「发条」的怪兽全部变成里侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--伝説のゼンマイ
function c69320362.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c69320362.target)
	e1:SetOperation(c69320362.activate)
	c:RegisterEffect(e1)
end
function c69320362.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x58) and c:IsCanTurnSet()
end
function c69320362.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c69320362.filter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c69320362.filter,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c69320362.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c69320362.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
	end
end
