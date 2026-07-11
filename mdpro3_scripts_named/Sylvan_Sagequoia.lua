--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Sylvan Sagequoia  (ID: 10530913)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Plant
-- Level: 7
-- ATK 2600 | DEF 2100
-- Setcode: 0x90
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a "Sylvan" monster is sent to the Graveyard (except during the Damage Step): You can Special
-- Summon this card from your hand.
-- Once per turn: You can excavate the top card of your Deck, and if it is a Plant-Type monster, send
-- it to the Graveyard.
-- Otherwise, place it on the bottom of your Deck.
-- If this card is excavated from the Deck and sent to the Graveyard by a card effect: You can target 1
-- "Sylvan" Spell/Trap Card in your Graveyard; add that target to your hand.
--[[ __CARD_HEADER_END__ ]]

--森羅の賢樹 シャーマン
function c10530913.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10530913,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c10530913.spcon)
	e1:SetTarget(c10530913.sptg)
	e1:SetOperation(c10530913.spop)
	c:RegisterEffect(e1)
	--deck check
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10530913,1))
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c10530913.target)
	e2:SetOperation(c10530913.operation)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10530913,2))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c10530913.thcon)
	e3:SetTarget(c10530913.thtg)
	e3:SetOperation(c10530913.thop)
	c:RegisterEffect(e3)
end
function c10530913.cfilter(c)
	return c:IsSetCard(0x90) and c:IsType(TYPE_MONSTER)
end
function c10530913.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10530913.cfilter,1,nil)
end
function c10530913.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c10530913.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c10530913.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function c10530913.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsRace(RACE_PLANT) then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
	else
		Duel.MoveSequence(tc,SEQ_DECKBOTTOM)
	end
end
function c10530913.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_DECK) and c:IsReason(REASON_REVEAL)
end
function c10530913.thfilter(c)
	return c:IsSetCard(0x90) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c10530913.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c10530913.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c10530913.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c10530913.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c10530913.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
