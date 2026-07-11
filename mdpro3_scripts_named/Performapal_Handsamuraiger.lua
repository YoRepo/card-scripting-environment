--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Performapal Handsamuraiger  (ID: 55997110)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level: 4
-- ATK 1800 | DEF 400
-- Setcode: 0x9f
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card destroys an opponent's monster by battle and sends it to the GY: You can add 1 Level
-- 5 or higher Pendulum Monster from your Deck to your hand.
-- You can only use this effect of "Performapal Handsamuraiger" once per turn.
--[[ __CARD_HEADER_END__ ]]

--EMハンサムライガー
function c55997110.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(55997110,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCountLimit(1,55997110)
	e1:SetCondition(aux.bdogcon)
	e1:SetTarget(c55997110.target)
	e1:SetOperation(c55997110.operation)
	c:RegisterEffect(e1)
end
function c55997110.filter(c)
	return c:IsLevelAbove(5) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c55997110.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c55997110.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c55997110.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c55997110.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
