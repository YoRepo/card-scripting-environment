--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: The Agent of Mystery - Earth  (ID: 91188343)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 2
-- ATK 1000 | DEF 800
-- Setcode: 0x44
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned: You can add 1 "The Agent" monster from your Deck to your hand,
-- except "The Agent of Mystery - Earth" or, if "The Sanctuary in the Sky" is on the field, you can add
-- 1 "Master Hyperion" from your Deck to your hand instead.
--[[ __CARD_HEADER_END__ ]]

--神秘の代行者 アース
function c91188343.initial_effect(c)
	aux.AddCodeList(c,56433456)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91188343,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c91188343.tg)
	e1:SetOperation(c91188343.op)
	c:RegisterEffect(e1)
end
function c91188343.filter1(c)
	return c:IsSetCard(0x44) and not c:IsCode(91188343) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c91188343.filter2(c)
	return ((c:IsSetCard(0x44) and not c:IsCode(91188343) and c:IsType(TYPE_MONSTER)) or c:IsCode(55794644)) and c:IsAbleToHand()
end
function c91188343.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if not Duel.IsEnvironment(56433456) then
			return Duel.IsExistingMatchingCard(c91188343.filter1,tp,LOCATION_DECK,0,1,nil) end
		return Duel.IsExistingMatchingCard(c91188343.filter2,tp,LOCATION_DECK,0,1,nil)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c91188343.op(e,tp,eg,ep,ev,re,r,rp)
	local g=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	if not Duel.IsEnvironment(56433456) then
		g=Duel.SelectMatchingCard(tp,c91188343.filter1,tp,LOCATION_DECK,0,1,1,nil)
	else g=Duel.SelectMatchingCard(tp,c91188343.filter2,tp,LOCATION_DECK,0,1,1,nil) end
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
