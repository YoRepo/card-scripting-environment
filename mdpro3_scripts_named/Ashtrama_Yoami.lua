--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-19T23:32:31
-- Source DB: test-release.cdb
-- Card: Ashtrama Yoami  (ID: 101307039)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Spellcaster
-- Level: 8
-- ATK 2400 | DEF 3000
-- Setcode: 0x1e4
-- Scope: OCG
--
-- Effect Text:
-- 1 Tuner + 1+ non-Tuners
-- If this card is Special Summoned, or sent from the field to the GY: You can add to your hand, or
-- Set, 1 "Ashtra" Trap from your Deck. If you have a Trap in your GY: You can return as many face-down
-- cards on the field as possible to the hand, then if you have 5 or more Traps in your GY, you can
-- return all cards your opponent controls to the hand. You can only use each effect of "Ashtrama
-- Yoami" once per turn.
--[[ __CARD_HEADER_END__ ]]

--鬼神 夜魅
local s,id,o=GetID()
function s.initial_effect(c)
	--Synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(s.thcon)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,id+o)
	e3:SetCondition(s.rthcon)
	e3:SetTarget(s.rthtg)
	e3:SetOperation(s.rthop)
	c:RegisterEffect(e3)
end
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function s.thfilter(c)
	if not (c:IsSetCard(0x1e4) and c:IsType(TYPE_TRAP)) then return false end
	return c:IsAbleToHand() or c:IsSSetable()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(id,0))
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		if tc:IsAbleToHand() and (not tc:IsSSetable() or Duel.SelectOption(tp,1190,1153)==0) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		elseif tc:IsSSetable() then
			Duel.SSet(tp,tc)
		end
	end
end
function s.rthcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_TRAP)
end
function s.rthfilter(c)
	return c:IsFacedown() and c:IsAbleToHand()
end
function s.rthtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.rthfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(s.rthfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount(),0,0)
end
function s.rthop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(s.rthfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if Duel.SendtoHand(sg,nil,REASON_EFFECT)~=0
		and sg:IsExists(Card.IsLocation,1,nil,LOCATION_HAND)
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,5,nil,TYPE_TRAP)
		and Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
		Duel.BreakEffect()
		local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,nil)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
