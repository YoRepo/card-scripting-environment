--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 圣刻神龙-九神龙  (ID: 64332231)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Dragon
-- Rank 8
-- ATK 3000 | DEF 2400
-- Setcode: 105
--
-- Effect Text:
-- 8星怪兽×2
-- ①：1回合1次，把这张卡1个超量素材取除才能发动。自己的手卡·场上的怪兽任意数量解放，选那个数量的场上的卡破坏。
--[[ __CARD_HEADER_END__ ]]

--聖刻神龍－エネアード
function c64332231.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,8,2)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64332231,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c64332231.descost)
	e1:SetTarget(c64332231.destg)
	e1:SetOperation(c64332231.desop)
	c:RegisterEffect(e1)
end
function c64332231.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c64332231.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(tp,nil,1,REASON_EFFECT,true,nil)
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c64332231.desop(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local rg=Duel.SelectReleaseGroupEx(tp,nil,1,ct1,REASON_EFFECT,true,nil)
	local ct2=Duel.Release(rg,REASON_EFFECT)
	if ct2==0 then return end
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,ct2,ct2,nil)
	Duel.HintSelection(dg)
	Duel.Destroy(dg,REASON_EFFECT)
end
