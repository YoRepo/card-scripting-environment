--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 重机王 土木·夏克  (ID: 29515122)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Machine
-- Rank 5
-- ATK 3200 | DEF 2000
--
-- Effect Text:
-- 5星怪兽×3
-- 1回合1次，把这张卡1个超量素材取除才能发动。从对方卡组上面把3张卡送去墓地。这个效果送去墓地的卡之中有怪兽卡的场合，把最多有那个数量的对方场上的卡破坏。
--[[ __CARD_HEADER_END__ ]]

--重機王ドボク・ザーク
function c29515122.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,3)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29515122,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c29515122.cost)
	e1:SetTarget(c29515122.target)
	e1:SetOperation(c29515122.operation)
	c:RegisterEffect(e1)
end
function c29515122.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c29515122.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(1-tp,3) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,3)
end
function c29515122.cfilter(c)
	return c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_MONSTER)
end
function c29515122.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,3,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	local ct=g:FilterCount(c29515122.cfilter,nil)
	if ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,ct,nil)
	if dg:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.HintSelection(dg)
	Duel.Destroy(dg,REASON_EFFECT)
end
