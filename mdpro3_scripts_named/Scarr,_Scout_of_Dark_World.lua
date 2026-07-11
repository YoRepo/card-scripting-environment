--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Scarr, Scout of Dark World  (ID: 5498296)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 2
-- ATK 500 | DEF 500
-- Setcode: 0x6
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is destroyed by battle and sent to the GY: Add 1 Level 4 or lower "Dark World" monster
-- from your Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--暗黒界の斥候 スカー
function c5498296.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5498296,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c5498296.condition)
	e1:SetTarget(c5498296.target)
	e1:SetOperation(c5498296.operation)
	c:RegisterEffect(e1)
end
function c5498296.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c5498296.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c5498296.filter(c)
	return c:IsLevelBelow(4) and c:IsSetCard(0x6) and c:IsAbleToHand()
end
function c5498296.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c5498296.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
