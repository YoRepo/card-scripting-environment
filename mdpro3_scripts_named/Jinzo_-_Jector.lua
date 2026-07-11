--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Jinzo - Jector  (ID: 51916032)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 4
-- ATK 800 | DEF 2000
-- Setcode: 0xbc
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card's name becomes "Jinzo" while on the field or in the GY.
-- You can Tribute this card; add 1 "Jinzo" monster from your Deck to your hand, except "Jinzo -
-- Jector", then reveal all Set cards in your opponent's Spell & Trap Zones, and if there are Traps
-- among them, you can Special Summon "Jinzo" monsters from your hand, up to the number of Traps
-- revealed.
-- You can only use this effect of "Jinzo - Jector" once per turn.
--[[ __CARD_HEADER_END__ ]]

--人造人間－サイコ・ジャッカー
function c51916032.initial_effect(c)
	--change
	aux.EnableChangeCode(c,77585513,LOCATION_MZONE+LOCATION_GRAVE)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51916032,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,51916032)
	e2:SetCost(c51916032.cost)
	e2:SetTarget(c51916032.target)
	e2:SetOperation(c51916032.operation)
	c:RegisterEffect(e2)
end
function c51916032.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c51916032.filter(c)
	return c:IsSetCard(0xbc) and not c:IsCode(51916032) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c51916032.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c51916032.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c51916032.cffilter(c)
	return c:IsFacedown() and c:GetSequence()<5
end
function c51916032.spfilter(c,e,tp)
	return c:IsSetCard(0xbc) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c51916032.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c51916032.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()==0 or Duel.SendtoHand(g,nil,REASON_EFFECT)==0 then return end
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	local cg=Duel.GetMatchingGroup(c51916032.cffilter,tp,0,LOCATION_SZONE,nil)
	if cg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.ConfirmCards(tp,cg)
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft<=0 then return end
		local ct=cg:FilterCount(Card.IsType,nil,TYPE_TRAP)
		if ct>ft then ct=ft end
		local sg=Duel.GetMatchingGroup(c51916032.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
		if ct>0 and sg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(51916032,1)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local tg=sg:Select(tp,1,ct,nil)
			Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
