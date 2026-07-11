--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Gryphon Wing  (ID: 55608151)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent activates "Harpie's Feather Duster": Negate its effect, and if you do, destroy
-- all Spells and Traps your opponent controls.
--[[ __CARD_HEADER_END__ ]]

--グリフォンの翼
function c55608151.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c55608151.condition)
	e1:SetTarget(c55608151.target)
	e1:SetOperation(c55608151.activate)
	c:RegisterEffect(e1)
end
function c55608151.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsCode(18144506) and Duel.IsChainDisablable(ev)
end
function c55608151.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c55608151.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c55608151.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	local g=Duel.GetMatchingGroup(c55608151.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c55608151.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) then
		local g=Duel.GetMatchingGroup(c55608151.filter,tp,0,LOCATION_ONFIELD,nil)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
