--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Sour Scheduling - Red Vinegar Vamoose  (ID: 65107325)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate this card only if your opponent controls a card in this Set card's column; return all other
-- cards in this card's column to the hand.
-- Neither player can use the unused zones in this card's column.
-- You can only control 1 "Sour Scheduling - Red Vinegar Vamoose".
--[[ __CARD_HEADER_END__ ]]

--赤酢の踏切
function c65107325.initial_effect(c)
	c:SetUniqueOnField(1,0,65107325)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCondition(c65107325.condition)
	e1:SetTarget(c65107325.target)
	e1:SetOperation(c65107325.operation)
	c:RegisterEffect(e1)
	--disable field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetValue(c65107325.disval)
	c:RegisterEffect(e2)
end
function c65107325.disval(e,tp)
	local c=e:GetHandler()
	return c:GetColumnZone(LOCATION_ONFIELD,0)
end
function c65107325.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_SZONE) and c:IsFacedown()
		and c:GetColumnGroup():IsExists(Card.IsControler,1,nil,1-tp)
end
function c65107325.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=c:GetColumnGroup()
	if chk==0 then return #g>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c65107325.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetColumnGroup()
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
