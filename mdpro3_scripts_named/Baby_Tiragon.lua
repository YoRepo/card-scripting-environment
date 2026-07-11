--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Baby Tiragon  (ID: 12533811)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Dragon
-- Rank: 1
-- ATK 900 | DEF 900
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 1 monsters
-- During your Main Phase 1: You can detach 1 Xyz Material from this card, then target 1 Level 1
-- monster you control; it can attack your opponent directly.
--[[ __CARD_HEADER_END__ ]]

--ベビー・トラゴン
function c12533811.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,3)
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(12533811,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c12533811.condition)
	e1:SetCost(c12533811.cost)
	e1:SetTarget(c12533811.target)
	e1:SetOperation(c12533811.operation)
	c:RegisterEffect(e1)
end
function c12533811.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c12533811.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c12533811.filter(c)
	return c:IsFaceup() and c:IsLevel(1) and c:GetEffectCount(EFFECT_DIRECT_ATTACK)==0
end
function c12533811.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c12533811.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c12533811.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c12533811.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c12533811.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
