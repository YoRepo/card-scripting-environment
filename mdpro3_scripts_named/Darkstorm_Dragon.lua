--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 暗黑暴风龙  (ID: 57662975)
-- Type: Monster / Effect / Gemini
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 2700 | DEF 2500
--
-- Effect Text:
-- ①：这张卡只要在场上·墓地存在，当作通常怪兽使用。
-- ②：可以把场上的当作通常怪兽使用的这张卡作为通常召唤作再1次召唤。那个场合这张卡变成当作效果怪兽使用并得到以下效果。
-- ●1回合1次，把自己场上1张表侧表示的魔法·陷阱卡送去墓地才能发动。场上的魔法·陷阱卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--ダークストーム・ドラゴン
function c57662975.initial_effect(c)
	aux.EnableDualAttribute(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(57662975,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.IsDualState)
	e1:SetCost(c57662975.cost)
	e1:SetTarget(c57662975.target)
	e1:SetOperation(c57662975.operation)
	c:RegisterEffect(e1)
end
function c57662975.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGraveAsCost()
end
function c57662975.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c57662975.cfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c57662975.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c57662975.dfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c57662975.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c57662975.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,2,nil) end
	local g=Duel.GetMatchingGroup(c57662975.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c57662975.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c57662975.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
