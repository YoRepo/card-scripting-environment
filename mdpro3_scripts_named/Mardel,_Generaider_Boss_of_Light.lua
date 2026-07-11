--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Mardel, Generaider Boss of Light  (ID: 13903402)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Plant
-- Level: 9
-- ATK 2400 | DEF 2400
-- Setcode: 0x134
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can only control 1 "Mardel, Generaider Boss of Light".
-- If this card is Normal or Special Summoned: You can add 1 "Generaider" card or 1 Plant monster from
-- your Deck to your hand, except "Mardel, Generaider Boss of Light".
-- You can only use this effect of "Mardel, Generaider Boss of Light" once per turn.
--[[ __CARD_HEADER_END__ ]]

--光の王 マルデル
function c13903402.initial_effect(c)
	c:SetUniqueOnField(1,0,13903402)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13903402,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,13903402)
	e1:SetTarget(c13903402.thtg)
	e1:SetOperation(c13903402.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c13903402.thfilter(c)
	return (c:IsSetCard(0x134) or c:IsRace(RACE_PLANT)) and not c:IsCode(13903402) and c:IsAbleToHand()
end
function c13903402.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13903402.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13903402.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c13903402.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
