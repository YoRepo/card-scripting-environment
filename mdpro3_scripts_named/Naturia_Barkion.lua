--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Naturia Barkion  (ID: 2956282)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Dragon
-- Level: 6
-- ATK 2500 | DEF 1800
-- Setcode: 0x2a
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 EARTH Tuner + 1+ non-Tuner EARTH monsters
-- When a Trap Card is activated (Quick Effect): You can banish 2 cards from your GY; negate the
-- activation, and if you do, destroy that card.
-- This card must be face-up on the field to activate and to resolve this effect.
--[[ __CARD_HEADER_END__ ]]

--ナチュル・パルキオン
function c2956282.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,c2956282.synfilter,aux.NonTuner(c2956282.synfilter),1)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2956282,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c2956282.discon)
	e1:SetCost(c2956282.discost)
	e1:SetTarget(c2956282.distg)
	e1:SetOperation(c2956282.disop)
	c:RegisterEffect(e1)
end
function c2956282.synfilter(c)
	return c:IsAttribute(ATTRIBUTE_EARTH)
end
function c2956282.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_TRAP) and Duel.IsChainNegatable(ev)
end
function c2956282.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemoveAsCost,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c2956282.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c2956282.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
