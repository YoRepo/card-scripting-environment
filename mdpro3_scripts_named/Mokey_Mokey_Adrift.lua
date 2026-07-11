--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Mokey Mokey Adrift  (ID: 99910751)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 1
-- ATK 300 | DEF 100
-- Setcode: 0x183
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card's name becomes "Mokey Mokey" and is treated as a Normal Monster while face-up on the field
-- or in the GY.
-- You can discard this card; add 1 "Mokey Mokey" card from your Deck to your hand, except "Mokey Mokey
-- Adrift".
--[[ __CARD_HEADER_END__ ]]

--はぐれ・もけもけ
function c99910751.initial_effect(c)
	--change name
	aux.EnableChangeCode(c,27288416,LOCATION_MZONE+LOCATION_GRAVE)
	--normal monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_TYPE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e1:SetValue(TYPE_NORMAL)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_REMOVE_TYPE)
	e2:SetValue(TYPE_EFFECT)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_HAND)
	e3:SetCost(c99910751.thcost)
	e3:SetTarget(c99910751.thtg)
	e3:SetOperation(c99910751.thop)
	c:RegisterEffect(e3)
end
function c99910751.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c99910751.thfilter(c)
	return not c:IsCode(99910751) and c:IsSetCard(0x183) and c:IsAbleToHand()
end
function c99910751.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c99910751.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c99910751.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c99910751.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
