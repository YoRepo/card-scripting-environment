--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Wattcobra  (ID: 88205593)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 4
-- ATK 1000 | DEF 500
-- Setcode: 0xe
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can attack directly.
-- If this card inflicts battle damage to your opponent by a direct attack: Add 1 "Watt" monster from
-- your Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--エレキングコブラ
function c88205593.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88205593,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c88205593.condition)
	e2:SetTarget(c88205593.target)
	e2:SetOperation(c88205593.operation)
	c:RegisterEffect(e2)
end
function c88205593.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetAttackTarget()==nil
end
function c88205593.filter(c)
	return c:IsSetCard(0xe) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c88205593.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c88205593.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c88205593.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
