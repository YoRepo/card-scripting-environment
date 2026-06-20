--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 背德的堕天使  (ID: 50501121)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 239
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从自己的手卡·场上（表侧表示）把1只「堕天使」怪兽送去墓地才能发动。场上1张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--背徳の堕天使
function c50501121.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,50501121+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c50501121.cost)
	e1:SetTarget(c50501121.target)
	e1:SetOperation(c50501121.activate)
	c:RegisterEffect(e1)
end
function c50501121.costfilter(c,ec)
	return c:IsSetCard(0xef)
		and c:IsType(TYPE_MONSTER) and c:IsFaceupEx() and c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(nil,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,Group.FromCards(c,ec))
end
function c50501121.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c50501121.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c50501121.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,c)
	Duel.SendtoGrave(g,REASON_COST)
end
function c50501121.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local exc=nil
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then exc=e:GetHandler() end
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,exc)
	if chk==0 then return g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c50501121.activate(e,tp,eg,ep,ev,re,r,rp)
	local exc=nil
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then exc=e:GetHandler() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,exc)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
