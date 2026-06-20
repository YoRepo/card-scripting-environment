--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 侵入魔鬼·蟑蠊  (ID: 37926346)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Fiend
-- Rank 4
-- ATK 1900 | DEF 0
-- Setcode: 4106
--
-- Effect Text:
-- 4星怪兽×2
-- 可以把这张卡1个超量素材取除，5星以上的怪兽的特殊召唤无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--インヴェルズ・ローチ
function c37926346.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetDescription(aux.Stringid(37926346,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetCondition(c37926346.condition)
	e1:SetCost(c37926346.cost)
	e1:SetTarget(c37926346.target)
	e1:SetOperation(c37926346.operation)
	c:RegisterEffect(e1)
end
function c37926346.filter(c)
	return c:IsLevelAbove(5)
end
function c37926346.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and eg:IsExists(c37926346.filter,1,nil)
end
function c37926346.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c37926346.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c37926346.filter,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c37926346.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c37926346.filter,nil)
	Duel.NegateSummon(g)
	Duel.Destroy(g,REASON_EFFECT)
end
