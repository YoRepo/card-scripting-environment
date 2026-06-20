--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 超量爆发  (ID: 30600344)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 115
--
-- Effect Text:
-- 自己场上有6阶以上的超量怪兽存在的场合才能发动。对方场上盖放的卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--エクシーズ・バースト
function c30600344.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c30600344.condition)
	e1:SetTarget(c30600344.target)
	e1:SetOperation(c30600344.activate)
	c:RegisterEffect(e1)
end
function c30600344.cfilter(c)
	return c:IsFaceup() and c:IsRankAbove(6)
end
function c30600344.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c30600344.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c30600344.filter(c)
	return c:IsFacedown()
end
function c30600344.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c30600344.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c30600344.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c30600344.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c30600344.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
