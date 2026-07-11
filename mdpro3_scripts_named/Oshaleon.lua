--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Oshaleon  (ID: 71519605)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Reptile
-- Level: 3
-- ATK 1400 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- While you control this face-up Attack Position card, your opponent cannot select a monster other
-- than "Oshaleon" as an attack target.
-- When this card is destroyed by battle and sent to the Graveyard, you can add 1 Reptile-Type monster
-- with 500 or less ATK from your Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--オシャレオン
function c71519605.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(71519605,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c71519605.condition)
	e1:SetTarget(c71519605.target)
	e1:SetOperation(c71519605.operation)
	c:RegisterEffect(e1)
	--attack limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c71519605.atcon)
	e2:SetValue(c71519605.atlimit)
	c:RegisterEffect(e2)
end
function c71519605.atcon(e)
	return e:GetHandler():IsAttackPos()
end
function c71519605.atlimit(e,c)
	return c:IsFacedown() or not c:IsCode(71519605)
end
function c71519605.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c71519605.filter(c)
	return c:IsAttackBelow(500) and c:IsRace(RACE_REPTILE) and c:IsAbleToHand()
end
function c71519605.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c71519605.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c71519605.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c71519605.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
