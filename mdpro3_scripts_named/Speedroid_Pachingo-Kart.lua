--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Speedroid Pachingo-Kart  (ID: 85034450)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level: 4
-- ATK 1800 | DEF 1000
-- Setcode: 0x2016
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can discard 1 Machine-Type monster, then target 1 monster on the field; destroy
-- it.
--[[ __CARD_HEADER_END__ ]]

--SRパチンゴーカート
function c85034450.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c85034450.descost)
	e1:SetTarget(c85034450.destg)
	e1:SetOperation(c85034450.desop)
	c:RegisterEffect(e1)
end
function c85034450.cfilter(c)
	return c:IsDiscardable() and c:IsRace(RACE_MACHINE)
end
function c85034450.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c85034450.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c85034450.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c85034450.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c85034450.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
