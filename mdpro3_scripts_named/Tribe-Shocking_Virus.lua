--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 同族感电病毒  (ID: 86361354)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Thunder
-- Level 4
-- ATK 1700 | DEF 1000
--
-- Effect Text:
-- 1回合1次，把手卡1只怪兽从游戏中除外才能发动。和为这个效果发动而从游戏中除外的怪兽相同种族的场上表侧表示存在的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--同族感電ウィルス
function c86361354.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86361354,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c86361354.cost)
	e1:SetTarget(c86361354.target)
	e1:SetOperation(c86361354.operation)
	c:RegisterEffect(e1)
end
function c86361354.cfilter(c)
	local rc=c:GetRace()
	return rc~=0 and c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c86361354.dfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil,rc)
end
function c86361354.dfilter(c,rc)
	return c:IsFaceup() and c:IsRace(rc)
end
function c86361354.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c86361354.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c86361354.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	e:SetLabel(g:GetFirst():GetRace())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c86361354.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c86361354.dfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil,e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c86361354.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c86361354.dfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil,e:GetLabel())
	Duel.Destroy(g,REASON_EFFECT)
end
