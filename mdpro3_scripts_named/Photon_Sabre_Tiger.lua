--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Photon Sabre Tiger  (ID: 80495985)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level: 3
-- ATK 2000 | DEF 300
-- Setcode: 0x55
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal or Flip Summoned: You can add 1 "Photon Sabre Tiger" from your Deck to your
-- hand.
-- If you do not control another "Photon Sabre Tiger", this card loses 800 ATK.
--[[ __CARD_HEADER_END__ ]]

--フォトン・サーベルタイガー
function c80495985.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80495985,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c80495985.thtg)
	e1:SetOperation(c80495985.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--atkdown
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetCondition(c80495985.atcon)
	e3:SetValue(-800)
	c:RegisterEffect(e3)
end
function c80495985.filter(c)
	return c:IsCode(80495985) and c:IsAbleToHand()
end
function c80495985.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80495985.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c80495985.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstMatchingCard(c80495985.filter,tp,LOCATION_DECK,0,nil)
	if tc then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c80495985.atfilter(c)
	return c:IsFaceup() and c:IsCode(80495985)
end
function c80495985.atcon(e)
	return not Duel.IsExistingMatchingCard(c80495985.atfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,e:GetHandler())
end
