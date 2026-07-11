--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Goblin Recon Squad  (ID: 82324312)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level: 4
-- ATK 1700 | DEF 0
-- Setcode: 0xac
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card successfully attacks directly, you can look at 1 random card in your opponent's hand.
-- If it is a Spell Card, send it to the Graveyard.
-- If this card attacks, it is changed to Defense Position at the end of the Battle Phase.
-- This card's battle position cannot be changed until the end of your next turn, except with a card
-- effect.
--[[ __CARD_HEADER_END__ ]]

--ゴブリン偵察部隊
function c82324312.initial_effect(c)
	--confirm
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82324312,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c82324312.condition)
	e1:SetOperation(c82324312.operation)
	c:RegisterEffect(e1)
	--to defense
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c82324312.poscon)
	e2:SetOperation(c82324312.posop)
	c:RegisterEffect(e2)
end
function c82324312.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetAttackTarget()==nil
end
function c82324312.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(ep,LOCATION_HAND,0)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(ep,1)
	Duel.ConfirmCards(tp,sg)
	if sg:GetFirst():IsType(TYPE_SPELL) then
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
	Duel.ShuffleHand(1-tp)
end
function c82324312.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttackedCount()>0
end
function c82324312.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsAttackPos() then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,3)
	c:RegisterEffect(e1)
end
