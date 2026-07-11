--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Stinging Swordsman  (ID: 68167124)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level: 1
-- ATK 300 | DEF 600
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card inflicts Battle Damage to your opponent: Return all face-up cards in your opponent's
-- Spell & Trap Card Zones to the hand.
--[[ __CARD_HEADER_END__ ]]

--針剣士
function c68167124.initial_effect(c)
	--return
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68167124,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c68167124.condition)
	e1:SetTarget(c68167124.target)
	e1:SetOperation(c68167124.operation)
	c:RegisterEffect(e1)
end
function c68167124.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c68167124.filter(c)
	return c:IsFaceup() and c:GetSequence()<5
end
function c68167124.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c68167124.filter,tp,0,LOCATION_SZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c68167124.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c68167124.filter,tp,0,LOCATION_SZONE,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
