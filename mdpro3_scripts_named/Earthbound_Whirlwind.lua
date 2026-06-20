--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 地缚旋风  (ID: 96907086)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 33
--
-- Effect Text:
-- 自己场上有名字带有「地缚神」的怪兽表侧表示存在的场合才能发动。对方场上存在的魔法·陷阱卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--地縛旋風
function c96907086.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c96907086.condition)
	e1:SetTarget(c96907086.target)
	e1:SetOperation(c96907086.activate)
	c:RegisterEffect(e1)
end
function c96907086.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1021)
end
function c96907086.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c96907086.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c96907086.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c96907086.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c96907086.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c96907086.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c96907086.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c96907086.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
