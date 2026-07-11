--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Griggle  (ID: 95744531)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 1
-- ATK 350 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- When the control of this face-up card on the field shifts to your opponent, increase your Life
-- Points by 3000 points.
-- This effect can only be used once as long as this card remains face-up on the field.
--[[ __CARD_HEADER_END__ ]]

--グリグル
function c95744531.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95744531,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CONTROL_CHANGED)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCountLimit(1)
	e1:SetTarget(c95744531.target)
	e1:SetOperation(c95744531.operation)
	c:RegisterEffect(e1)
end
function c95744531.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING) end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,1-tp,3000)
end
function c95744531.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(1-tp,3000,REASON_EFFECT)
end
