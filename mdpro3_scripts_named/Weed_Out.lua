--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Weed Out  (ID: 28604635)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pay 500 Life Points.
-- Destroy all face-up Attack Position Level 3 monsters.
--[[ __CARD_HEADER_END__ ]]

--ふるい落とし
function c28604635.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c28604635.cost)
	e1:SetTarget(c28604635.target)
	e1:SetOperation(c28604635.activate)
	c:RegisterEffect(e1)
end
function c28604635.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c28604635.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsLevel(3)
end
function c28604635.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c28604635.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c28604635.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c28604635.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c28604635.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
