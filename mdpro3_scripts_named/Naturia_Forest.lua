--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Naturia Forest  (ID: 37322745)
-- Type: Spell / Field
-- Setcode: 0x2a
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you negate the activation of an opponent's Spell/Trap Card(s), or opponent's monster effect(s)
-- (except during the Damage Step): You can add 1 Level 3 or lower "Naturia" monster from your Deck to
-- your hand.
--[[ __CARD_HEADER_END__ ]]

--ナチュルの森
function c37322745.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetDescription(aux.Stringid(37322745,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EVENT_CHAIN_NEGATED)
	e2:SetCondition(c37322745.condition)
	e2:SetTarget(c37322745.target)
	e2:SetOperation(c37322745.operation)
	c:RegisterEffect(e2)
end
function c37322745.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c37322745.filter(c)
	return c:IsLevelBelow(3) and c:IsSetCard(0x2a) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c37322745.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING)
		and Duel.IsExistingMatchingCard(c37322745.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c37322745.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c37322745.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
