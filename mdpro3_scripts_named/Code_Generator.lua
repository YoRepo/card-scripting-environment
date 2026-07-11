--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Code Generator  (ID: 30114823)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Cyberse
-- Level: 3
-- ATK 1300 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a Cyberse monster you control would be used as Link Material for a "Code Talker" monster, this
-- card in your hand can also be used as material.
-- If this card is sent from the hand or field to the GY as material for the Link Summon of a "Code
-- Talker" monster: You can send 1 Cyberse monster with 1200 or less ATK from your Deck to the GY, or,
-- if this card on the field was used as material, you can add that card to your hand instead.
-- You can only use each effect of "Code Generator" once per turn.
--[[ __CARD_HEADER_END__ ]]

--コード・ジェネレーター
function c30114823.initial_effect(c)
	--hand link
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_EXTRA_LINK_MATERIAL)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,30114823)
	e1:SetValue(c30114823.matval)
	c:RegisterEffect(e1)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(30114823,0))
	e3:SetCategory(CATEGORY_DECKDES+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetCountLimit(1,30114824)
	e3:SetCondition(c30114823.tdcon)
	e3:SetTarget(c30114823.tdtg)
	e3:SetOperation(c30114823.tdop)
	c:RegisterEffect(e3)
end
function c30114823.mfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsRace(RACE_CYBERSE) and c:IsControler(tp)
end
function c30114823.exmfilter(c)
	return c:IsLocation(LOCATION_HAND) and c:IsCode(30114823)
end
function c30114823.matval(e,lc,mg,c,tp)
	if not lc:IsSetCard(0x101) then return false,nil end
	return true,not mg or mg:IsExists(c30114823.mfilter,1,nil,tp) and not mg:IsExists(c30114823.exmfilter,1,nil)
end
function c30114823.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	e:SetLabel(0)
	if c:IsLocation(LOCATION_GRAVE) and c:IsPreviousLocation(LOCATION_ONFIELD+LOCATION_HAND) and r==REASON_LINK and c:GetReasonCard():IsSetCard(0x101) then
		if c:IsPreviousLocation(LOCATION_ONFIELD) then
			e:SetLabel(1)
			c:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(30114823,1))
		end
		return true
	else
		return false
	end
end
function c30114823.tdfilter(c,chk)
	return c:IsRace(RACE_CYBERSE) and c:IsAttackBelow(1200) and (c:IsAbleToGrave() or (chk==1 and c:IsAbleToHand()))
end
function c30114823.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c30114823.tdfilter,tp,LOCATION_DECK,0,1,nil,e:GetLabel()) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c30114823.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c30114823.tdfilter,tp,LOCATION_DECK,0,1,1,nil,e:GetLabel())
	local tc=g:GetFirst()
	if not tc then return end
	if tc:IsAbleToGrave() and (e:GetLabel()==0 or not tc:IsAbleToHand() or Duel.SelectOption(tp,1191,1190)==0) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	else
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
