--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Heroic Challenger - Clasp Sword  (ID: 28194325)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 1
-- ATK 300 | DEF 100
-- Setcode: 0x106f
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Special Summoned by the effect of a "Heroic Challenger" monster: You can add 1
-- "Heroic Challenger" monster from your Deck to your hand.
-- You can only use this effect of "Heroic Challenger - Clasp Sword" once per turn.
--[[ __CARD_HEADER_END__ ]]

--H・C クラスプ・ナイフ
function c28194325.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(28194325,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,28194325)
	e1:SetCondition(c28194325.condition)
	e1:SetTarget(c28194325.target)
	e1:SetOperation(c28194325.operation)
	c:RegisterEffect(e1)
end
function c28194325.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetSpecialSummonInfo(SUMMON_INFO_TYPE)&TYPE_MONSTER~=0 and c:IsSpecialSummonSetCard(0x106f)
end
function c28194325.filter(c)
	return c:IsSetCard(0x106f) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c28194325.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c28194325.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c28194325.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c28194325.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
