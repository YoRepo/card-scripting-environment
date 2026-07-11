--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Fossil Dragon Skullgar  (ID: 12015000)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Rock
-- Level: 4
-- ATK 2500 | DEF 0
-- Setcode: 0x149
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Rock monster + 1 Level 4 or lower monster in your opponent's GY
-- Must first be Special Summoned with "Fossil Fusion".
-- If this card attacks a Defense Position monster, inflict piercing battle damage.
-- You can banish this card from your GY; add 1 "Fossil Fusion" from your Deck to your hand.
-- You can only use this effect of "Fossil Dragon Skullgar" once per turn.
--[[ __CARD_HEADER_END__ ]]

--新生代化石竜 スカルガー
function c12015000.initial_effect(c)
	aux.AddCodeList(c,59419719)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsRace,RACE_ROCK),c12015000.matfilter,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FossilFusionLimit)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(12015000,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,12015000)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c12015000.thtg)
	e3:SetOperation(c12015000.thop)
	c:RegisterEffect(e3)
end
function c12015000.matfilter(c,fc)
	return c:IsFusionType(TYPE_MONSTER) and c:GetLevel()>0 and c:IsLevelBelow(4) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(1-fc:GetControler())
end
function c12015000.thfilter(c)
	return c:IsCode(59419719) and c:IsAbleToHand()
end
function c12015000.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c12015000.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c12015000.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c12015000.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
