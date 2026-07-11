--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Han-Shi Kyudo Spirit  (ID: 53270092)
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
-- If a monster(s) is Pendulum Summoned: Return this card to the hand.
-- ----------------------------------------
-- [ Monster Effect ]
-- When this card is Normal Summoned: You can return all cards you control in the same column as the
-- cards in your Pendulum Zones to the hand (including the Pendulum Zone cards themselves), then you
-- can add 1 monster with 2400 ATK/1000 DEF from your Deck to your hand, except "Han-Shi Kyudo Spirit".
-- Once per turn, during the End Phase, if this card was Normal Summoned or flipped face-up this turn:
-- Return this card to the hand.
--[[ __CARD_HEADER_END__ ]]

--キュウドウ魂 HAN－SHI
local s,id,o=GetID()
function s.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--pzone to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(s.thcon)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
	--to hand and search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(s.gytg)
	e2:SetOperation(s.gyop)
	c:RegisterEffect(e2)
end
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsSummonType,1,nil,SUMMON_TYPE_PENDULUM)
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SendtoHand(c,nil,REASON_EFFECT)
end
function s.tgfilter(c,tp)
	local g=c:GetColumnGroup()
	g:AddCard(c)
	return Duel.IsExistingMatchingCard(s.gyfilter,tp,LOCATION_ONFIELD,0,1,nil,g)
end
function s.gyfilter(c,g)
	return g:IsContains(c) and c:IsAbleToHand()
end
function s.thfilter(c)
	return not c:IsCode(id) and c:IsAttack(2400) and c:IsDefense(1000)
		and c:IsAbleToHand()
end
function s.gytg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_PZONE,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,0,1-tp,LOCATION_MZONE)
end
function s.gyop(e,tp,eg,ep,ev,re,r,rp)
	local pg=Duel.GetMatchingGroup(s.tgfilter,tp,LOCATION_PZONE,0,nil,tp)
	if pg:GetCount()==0 then return end
	local tg=Group.CreateGroup()
	for pc in aux.Next(pg) do
		local g=pc:GetColumnGroup()
		g:AddCard(pc)
		tg:Merge(Duel.GetMatchingGroup(s.gyfilter,tp,LOCATION_ONFIELD,0,nil,g))
	end
	if #tg>0 and Duel.SendtoHand(tg,nil,REASON_EFFECT)~=0
		and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if sg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
