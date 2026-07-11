--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Curious, the Lightsworn Dominion  (ID: 98095162)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Warrior
-- Link Rating: 3
-- Link Arrows: Top, Bottom-Left, Bottom-Right
-- ATK 2400
-- Setcode: 0x38
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 monsters with the same Attribute but different Types
-- If this face-up card is destroyed by battle, or leaves the field because of an opponent's card
-- effect while its owner controls it: You can target 1 card in your GY; add it to your hand.
-- You can only use each of the following effects of "Curious, the Lightsworn Dominion" once per turn.
-- ● If this card is Link Summoned: You can send 1 card from your Deck to the GY.
-- ● If a card(s) is sent from your Deck to the GY by an effect: Send the top 3 cards of your Deck to
-- the GY.
--[[ __CARD_HEADER_END__ ]]

--ライトロード・ドミニオン キュリオス
function c98095162.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,3,3,c98095162.lcheck)
	c:EnableReviveLimit()
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98095162,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,98095162)
	e1:SetCondition(c98095162.tgcon)
	e1:SetTarget(c98095162.tgtg)
	e1:SetOperation(c98095162.tgop)
	c:RegisterEffect(e1)
	--discard deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98095162,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,98095163)
	e2:SetCondition(c98095162.ddcon)
	e2:SetTarget(c98095162.ddtg)
	e2:SetOperation(c98095162.ddop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98095162,2))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c98095162.thcon)
	e3:SetTarget(c98095162.thtg)
	e3:SetOperation(c98095162.thop)
	c:RegisterEffect(e3)
end
function c98095162.lcheck(g)
	local tc=g:GetFirst()
	return aux.SameValueCheck(g,Card.GetLinkAttribute) and g:GetClassCount(Card.GetLinkRace)==#g
end
function c98095162.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c98095162.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c98095162.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c98095162.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_DECK) and c:IsPreviousControler(tp)
end
function c98095162.ddcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and eg:IsExists(c98095162.cfilter,1,nil,tp)
end
function c98095162.ddtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,3)
end
function c98095162.ddop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,3,REASON_EFFECT)
end
function c98095162.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (c:IsReason(REASON_BATTLE) or (c:GetReasonPlayer()==1-tp and c:IsReason(REASON_EFFECT) and c:IsPreviousControler(tp)))
		and c:IsPreviousPosition(POS_FACEUP)
end
function c98095162.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c98095162.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
