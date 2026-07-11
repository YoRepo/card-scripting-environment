--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Ameba  (ID: 95174353)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 1
-- ATK 300 | DEF 350
-- Scope: OCG / TCG
--
-- Effect Text:
-- When the control of this face-up card on the field shifts to your opponent, inflict 2000 points of
-- damage to your opponent's Life Points.
-- This effect can only be used once as long as this card remains face-up on the field.
--[[ __CARD_HEADER_END__ ]]

--アメーバ
function c95174353.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95174353,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CONTROL_CHANGED)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCountLimit(1)
	e1:SetTarget(c95174353.target)
	e1:SetOperation(c95174353.operation)
	c:RegisterEffect(e1)
end
function c95174353.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING) end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,2000)
end
function c95174353.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,2000,REASON_EFFECT)
end
