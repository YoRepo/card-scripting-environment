--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Shaddoll Hedgehog  (ID: 4939890)
-- Type: Monster / Effect / Flip
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 3
-- ATK 800 | DEF 200
-- Setcode: 0x9d
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: You can add 1 "Shaddoll" Spell/Trap from your Deck to your hand.
-- If this card is sent to the GY by a card effect: You can add 1 "Shaddoll" monster from your Deck to
-- your hand, except "Shaddoll Hedgehog".
-- You can only use 1 "Shaddoll Hedgehog" effect per turn, and only once that turn.
--[[ __CARD_HEADER_END__ ]]

--シャドール・ヘッジホッグ
function c4939890.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(4939890,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,4939890)
	e1:SetCost(c4939890.cost)
	e1:SetTarget(c4939890.target)
	e1:SetOperation(c4939890.operation)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(4939890,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,4939890)
	e2:SetCondition(c4939890.thcon)
	e2:SetCost(c4939890.cost)
	e2:SetTarget(c4939890.thtg)
	e2:SetOperation(c4939890.thop)
	c:RegisterEffect(e2)
	c4939890.shadoll_flip_effect=e1
end
function c4939890.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c4939890.filter(c)
	return c:IsSetCard(0x9d) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c4939890.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c4939890.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c4939890.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c4939890.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c4939890.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_EFFECT)
end
function c4939890.thfilter(c)
	return c:IsSetCard(0x9d) and c:IsType(TYPE_MONSTER) and not c:IsCode(4939890) and c:IsAbleToHand()
end
function c4939890.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c4939890.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c4939890.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c4939890.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
