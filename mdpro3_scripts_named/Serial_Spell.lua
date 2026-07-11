--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Serial Spell  (ID: 49398568)
-- Type: Spell / Quick-Play
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only when you activate one of your Normal Spell Cards.
-- Discard all the cards in your hand to the Graveyard.
-- The effect of this card becomes the same as the Normal Spell Card.
--[[ __CARD_HEADER_END__ ]]

--連続魔法
function c49398568.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c49398568.condition)
	e1:SetCost(c49398568.cost)
	e1:SetTarget(c49398568.target)
	e1:SetOperation(c49398568.activate)
	c:RegisterEffect(e1)
end
function c49398568.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:GetActiveType()==TYPE_SPELL and re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp==tp
end
function c49398568.cfilter(c)
	return c:IsDiscardable() and c:IsAbleToGraveAsCost()
end
function c49398568.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	hg:RemoveCard(e:GetHandler())
	if chk==0 then return hg:GetCount()>0 and hg:FilterCount(c49398568.cfilter,nil)==hg:GetCount() end
	Duel.SendtoGrave(hg,REASON_COST+REASON_DISCARD)
end
function c49398568.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ftg=re:GetTarget()
	if chkc then return ftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc) end
	if chk==0 then
		e:SetCostCheck(false)
		return not ftg or ftg(e,tp,eg,ep,ev,re,r,rp,chk)
	end
	if re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	end
	if ftg then
		e:SetCostCheck(false)
		ftg(e,tp,eg,ep,ev,re,r,rp,chk)
	end
	Duel.ClearOperationInfo(0)
end
function c49398568.activate(e,tp,eg,ep,ev,re,r,rp)
	local fop=re:GetOperation()
	fop(e,tp,eg,ep,ev,re,r,rp)
end
