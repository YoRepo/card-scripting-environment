--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Fabled Kushano  (ID: 97439806)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Fiend
-- Level: 3
-- ATK 1100 | DEF 800
-- Setcode: 0x35
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is in your GY: You can discard 1 "Fabled" monster to the GY, except "Fabled Kushano";
-- add this card to your hand.
--[[ __CARD_HEADER_END__ ]]

--魔轟神クシャノ
function c97439806.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(97439806,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(c97439806.cost)
	e1:SetTarget(c97439806.tg)
	e1:SetOperation(c97439806.op)
	c:RegisterEffect(e1)
end
function c97439806.costfilter(c)
	return c:IsSetCard(0x35) and c:IsType(TYPE_MONSTER) and not c:IsCode(97439806)
		and c:IsDiscardable() and c:IsAbleToGraveAsCost()
end
function c97439806.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c97439806.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c97439806.costfilter,1,1,REASON_DISCARD+REASON_COST)
end
function c97439806.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c97439806.op(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,e:GetHandler())
	end
end
