--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Constellar Antares  (ID: 42391240)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level: 6
-- ATK 2400 | DEF 900
-- Setcode: 0x53
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal or Special Summoned: You can target 1 "Constellar" monster in your
-- Graveyard; add that target to your hand.
--[[ __CARD_HEADER_END__ ]]

--セイクリッド・アンタレス
function c42391240.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42391240,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c42391240.thtg)
	e1:SetOperation(c42391240.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	c42391240.star_knight_summon_effect=e1
end
function c42391240.tgfilter(c)
	return c:IsSetCard(0x53) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c42391240.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc,exc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c42391240.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c42391240.tgfilter,tp,LOCATION_GRAVE,0,1,exc) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c42391240.tgfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c42391240.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
