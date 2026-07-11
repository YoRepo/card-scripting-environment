--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Phantom Dragonray Bronto  (ID: 43191636)
-- Type: Monster / Effect / Gemini
-- Attribute: WATER
-- Race: Fish
-- Level: 4
-- ATK 1500 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the Graveyard.
-- While this card is face-up on the field, you can Normal Summon it to have it be treated as an Effect
-- Monster with this effect:
-- ● The original ATK of this card becomes 2300.
-- If this card attacks, it is changed to Defense Position at the end of the Battle Phase.
-- This card's battle position cannot be changed until the end of your next turn, except with a card
-- effect.
--[[ __CARD_HEADER_END__ ]]

--竜影魚レイ・ブロント
function c43191636.initial_effect(c)
	aux.EnableDualAttribute(c)
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.IsDualState)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(2300)
	c:RegisterEffect(e1)
	--to defense
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c43191636.poscon)
	e2:SetOperation(c43191636.posop)
	c:RegisterEffect(e2)
end
function c43191636.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsDualState() and e:GetHandler():GetAttackedCount()>0
end
function c43191636.posop(e,tp,eg,ep,ev,re,r,rp)
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
