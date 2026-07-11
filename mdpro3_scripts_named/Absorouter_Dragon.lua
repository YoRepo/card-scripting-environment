--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Absorouter Dragon  (ID: 67748760)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level: 7
-- ATK 1200 | DEF 2800
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Rokket" monster, you can Special Summon this card (from your hand).
-- You can only Special Summon "Absorouter Dragon" once per turn this way.
-- If this card is sent to the GY: You can add 1 "Rokket" monster from your Deck to your hand.
-- You can only use this effect of "Absorouter Dragon" once per turn.
--[[ __CARD_HEADER_END__ ]]

--アブソルーター・ドラゴン
function c67748760.initial_effect(c)
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,67748760+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c67748760.sprcon)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(67748760,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,67748761)
	e2:SetTarget(c67748760.thtg)
	e2:SetOperation(c67748760.thop)
	c:RegisterEffect(e2)
end
function c67748760.sprfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x102)
end
function c67748760.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c67748760.sprfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c67748760.thfilter(c)
	return c:IsSetCard(0x102) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c67748760.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c67748760.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c67748760.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c67748760.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
