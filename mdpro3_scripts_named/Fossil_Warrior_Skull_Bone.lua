--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Fossil Warrior Skull Bone  (ID: 86520461)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Rock
-- Level: 4
-- ATK 2000 | DEF 800
-- Setcode: 0x149
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Rock monster + 1 Level 4 or lower monster
-- Must first be Special Summoned with "Fossil Fusion".
-- This card can make up to 2 attacks on monsters during each Battle Phase.
-- You can banish this card from your GY; add 1 "Time Stream" from your Deck to your hand.
-- You can only use this effect of "Fossil Warrior Skull Bone" once per turn.
--[[ __CARD_HEADER_END__ ]]

--新生代化石騎士 スカルポーン
function c86520461.initial_effect(c)
	aux.AddCodeList(c,59419719)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsRace,RACE_ROCK),c86520461.matfilter,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FossilFusionLimit)
	c:RegisterEffect(e1)
	--extra attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(86520461,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,86520461)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c86520461.thtg)
	e3:SetOperation(c86520461.thop)
	c:RegisterEffect(e3)
end
function c86520461.matfilter(c)
	return c:GetLevel()>0 and c:IsLevelBelow(4)
end
function c86520461.thfilter(c)
	return c:IsCode(85808813) and c:IsAbleToHand()
end
function c86520461.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c86520461.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c86520461.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c86520461.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
