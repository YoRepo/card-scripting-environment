--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Ancient Gear Golem - Ultimate Pound  (ID: 95735217)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 8
-- ATK 3000 | DEF 3000
-- Setcode: 0x7
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned.
-- If this card attacks a Defense Position monster, inflict piercing battle damage to your opponent.
-- Up to twice per turn, when this attacking card destroys a monster by battle: You can discard 1
-- Machine monster; this card can attack again in a row.
-- If this card on the field is destroyed by battle or card effect: You can add 1 "Polymerization" from
-- your Deck to your hand, and if you do, add 1 other "Ancient Gear" monster from your GY to your hand.
--[[ __CARD_HEADER_END__ ]]

--古代の機械巨人－アルティメット・パウンド
function c95735217.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	--extra attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(95735217,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCountLimit(2)
	e3:SetCondition(c95735217.atcon)
	e3:SetCost(c95735217.atcost)
	e3:SetOperation(c95735217.atop)
	c:RegisterEffect(e3)
	--to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(95735217,1))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c95735217.thcon)
	e4:SetTarget(c95735217.thtg)
	e4:SetOperation(c95735217.thop)
	c:RegisterEffect(e4)
end
function c95735217.atcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler() and aux.bdcon(e,tp,eg,ep,ev,re,r,rp)
		and e:GetHandler():IsChainAttackable(0)
end
function c95735217.costfilter(c)
	return c:IsRace(RACE_MACHINE) and c:IsDiscardable()
end
function c95735217.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c95735217.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c95735217.costfilter,1,1,REASON_DISCARD+REASON_COST)
end
function c95735217.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
function c95735217.thcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c95735217.thfilter1(c)
	return c:IsCode(24094653) and c:IsAbleToHand()
end
function c95735217.thfilter2(c)
	return c:IsSetCard(0x7) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c95735217.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c95735217.thfilter1,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingMatchingCard(c95735217.thfilter2,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_DECK+LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,LOCATION_GRAVE)
end
function c95735217.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,c95735217.thfilter1,tp,LOCATION_DECK,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g2=Duel.SelectMatchingCard(tp,c95735217.thfilter2,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
		if g2:GetCount()>0 then
			Duel.HintSelection(g2)
			Duel.SendtoHand(g2,nil,REASON_EFFECT)
		end
	end
end
