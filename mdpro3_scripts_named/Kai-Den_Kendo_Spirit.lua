--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Kai-Den Kendo Spirit  (ID: 71614230)
-- Type: Monster / Effect / Spirit / Pendulum
-- Attribute: WIND
-- Race: Warrior
-- Level: 5
-- ATK 2400 | DEF 1000
-- Pendulum Scale: L9 / R9
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 9
-- [ Pendulum Effect ]
-- If a monster(s) is Pendulum Summoned: Return this card from the Pendulum Zone to the hand.
-- ----------------------------------------
-- [ Monster Effect ]
-- When this card is Normal Summoned: You can choose 1 card in your Pendulum Zone, and send to the GY
-- all cards your opponent controls in the same column as that card.
-- Once per turn, during the End Phase, if this card was Normal Summoned or flipped face-up this turn:
-- Return this card to the hand.
--[[ __CARD_HEADER_END__ ]]

--ケンドウ魂 KAI－DEN
function c71614230.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(c71614230.thcon)
	e1:SetTarget(c71614230.thtg)
	e1:SetOperation(c71614230.thop)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c71614230.gytg)
	e2:SetOperation(c71614230.gyop)
	c:RegisterEffect(e2)
end
function c71614230.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsSummonType,1,nil,SUMMON_TYPE_PENDULUM)
end
function c71614230.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c71614230.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SendtoHand(c,nil,REASON_EFFECT)
end
function c71614230.tgfilter(c,tp)
	return Duel.IsExistingMatchingCard(c71614230.gyfilter,tp,0,LOCATION_ONFIELD,1,nil,c:GetColumnGroup())
end
function c71614230.gyfilter(c,g)
	return g:IsContains(c)
end
function c71614230.gytg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c71614230.tgfilter,tp,LOCATION_PZONE,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,0,1-tp,LOCATION_ONFIELD)
end
function c71614230.gyop(e,tp,eg,ep,ev,re,r,rp)
	local pg=Duel.SelectMatchingCard(tp,c71614230.tgfilter,tp,LOCATION_PZONE,0,1,1,nil,tp)
	if pg:GetCount()==0 then return end
	local g=Duel.GetMatchingGroup(c71614230.gyfilter,tp,0,LOCATION_ONFIELD,nil,pg:GetFirst():GetColumnGroup())
	Duel.SendtoGrave(g,REASON_EFFECT)
end
