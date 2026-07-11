--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Revendread Executor  (ID: 34093683)
-- Type: Monster / Effect / Ritual
-- Attribute: DARK
-- Race: Zombie
-- Level: 8
-- ATK 3000 | DEF 0
-- Setcode: 0x106
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with any "Vendread" Ritual Spell.
-- This card's name becomes "Revendread Slayer" while on the field.
-- While this Ritual Summoned card is on the field, your opponent cannot target cards you control with
-- card effects, except this card.
-- If this Ritual Summoned card is destroyed by battle, or is destroyed by an opponent's card effect
-- while in its owner's Monster Zone: You can add 1 "Vendread" card from your Deck to your hand.
-- You can only use this effect of "Revendread Executor" once per turn.
--[[ __CARD_HEADER_END__ ]]

--リヴェンデット・エグゼクター
function c34093683.initial_effect(c)
	c:EnableReviveLimit()
	--change name
	aux.EnableChangeCode(c,4388680)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetCondition(c34093683.tgcon)
	e2:SetTarget(c34093683.tgtg)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(34093683,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCountLimit(1,34093683)
	e3:SetCondition(c34093683.thcon)
	e3:SetTarget(c34093683.thtg)
	e3:SetOperation(c34093683.thop)
	c:RegisterEffect(e3)
end
function c34093683.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end
function c34093683.tgtg(e,c)
	return c~=e:GetHandler()
end
function c34093683.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (c:IsReason(REASON_BATTLE) or (rp==1-tp and c:IsReason(REASON_EFFECT) and c:IsPreviousControler(tp)))
		and c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_RITUAL)
end
function c34093683.thfilter(c)
	return c:IsSetCard(0x106) and c:IsAbleToHand()
end
function c34093683.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c34093683.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c34093683.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c34093683.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
