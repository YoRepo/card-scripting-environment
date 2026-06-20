--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 魔导法皇 海隆  (ID: 92918648)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Spellcaster
-- Rank 7
-- ATK 2800 | DEF 2600
-- Setcode: 110
--
-- Effect Text:
-- 魔法师族7星怪兽×2
-- 1回合1次，把这张卡1个超量素材取除才能发动。选最多有自己墓地的名字带有「魔导书」的魔法卡数量的对方场上的魔法·陷阱卡破坏。
--[[ __CARD_HEADER_END__ ]]

--魔導法皇 ハイロン
function c92918648.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),7,2)
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92918648,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c92918648.cost)
	e1:SetTarget(c92918648.target)
	e1:SetOperation(c92918648.operation)
	c:RegisterEffect(e1)
end
function c92918648.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c92918648.cfilter(c)
	return c:IsSetCard(0x106e) and c:IsType(TYPE_SPELL)
end
function c92918648.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c92918648.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92918648.cfilter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(c92918648.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c92918648.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c92918648.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c92918648.cfilter,tp,LOCATION_GRAVE,0,nil)
	if ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c92918648.filter,tp,0,LOCATION_ONFIELD,1,ct,nil)
	Duel.HintSelection(g)
	Duel.Destroy(g,REASON_EFFECT)
end
