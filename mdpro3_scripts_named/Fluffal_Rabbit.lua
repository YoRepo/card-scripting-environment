--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Fluffal Rabbit  (ID: 38124994)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level: 1
-- ATK 300 | DEF 1200
-- Setcode: 0xa9
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is sent to the Graveyard as a Fusion Material for a Fusion Summon: You can target 1
-- "Edge Imp Sabres" or 1 "Fluffal" monster in your Graveyard, except "Fluffal Rabbit"; add it to your
-- hand.
-- You can only use this effect of "Fluffal Rabbit" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ファーニマル・ラビット
function c38124994.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(38124994,1))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCountLimit(1,38124994)
	e1:SetCondition(c38124994.condition)
	e1:SetTarget(c38124994.target)
	e1:SetOperation(c38124994.operation)
	c:RegisterEffect(e1)
end
function c38124994.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_FUSION and not c:IsReason(REASON_RETURN)
end
function c38124994.filter(c)
	return (c:IsCode(30068120) or (c:IsSetCard(0xa9) and c:IsType(TYPE_MONSTER) and not c:IsCode(38124994)))
		and c:IsAbleToHand()
end
function c38124994.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c38124994.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c38124994.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c38124994.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c38124994.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
