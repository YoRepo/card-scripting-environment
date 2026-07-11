--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Darklord Enchantment  (ID: 87990236)
-- Type: Trap
-- Setcode: 0xef
-- Scope: OCG / TCG
--
-- Effect Text:
-- Send 1 "Darklord" monster from your hand or face-up field to the GY; take control of 1 face-up
-- monster your opponent controls until the End Phase.
-- You can only activate 1 "Darklord Enchantment" per turn.
--[[ __CARD_HEADER_END__ ]]

--魅惑の堕天使
function c87990236.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,87990236+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c87990236.cost)
	e1:SetTarget(c87990236.target)
	e1:SetOperation(c87990236.activate)
	c:RegisterEffect(e1)
end
function c87990236.costfilter(c,tp)
	return c:IsSetCard(0xef) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
		and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)>0
end
function c87990236.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return Duel.IsExistingMatchingCard(c87990236.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c87990236.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c87990236.filter(c,check)
	return c:IsControlerCanBeChanged(check) and c:IsFaceup()
end
function c87990236.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local check=e:GetLabel()==100
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c87990236.filter,tp,0,LOCATION_MZONE,1,nil,check)
	end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,0,0)
end
function c87990236.filter2(c)
	return c:IsControlerCanBeChanged() and c:IsFaceup()
end
function c87990236.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(tp,c87990236.filter2,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
