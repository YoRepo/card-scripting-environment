--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-10-16T00:00:00
-- Card: Amazoness Dramatic Rescue  (ID: 101403074)
-- Type: Trap / Normal
-- Setcode: 0x4 (Amazoness)
--
-- Effect Text:
-- You can only use the ①st and ②nd effects of this card's name each once per turn. If you control a
-- "Harpie Lady" monster or "Amazoness" monster, you can activate this card the turn it was Set.
-- ① Target 1 monster on the field; Special Summon 1 "Harpie" or "Amazoness" monster from your hand
-- or Deck, and if you do, return the targeted monster to the hand.
-- ② You can banish this card from your GY; add 1 "Harpie" or "Amazoness" monster from your GY or
-- banishment to your hand.
--[[ __CARD_HEADER_END__ ]]

--Amazoness Dramatic Rescue
local s,id,o=GetID()
function s.initial_effect(c)
	--names "Harpie Lady" and a "Harpie" monster (house convention: one call each)
	aux.AddCodeList(c,76812113)
	aux.AddSetNameMonsterList(c,0x64)
	--(1) target 1 monster on the field; Special Summon 1 "Harpie" or "Amazoness" monster from your hand or Deck,
	--and if you do, return the targeted monster to the hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	--"use the (1)st effect ... once per turn": a plain count code, not OATH (cf. Angelechy Disturbance)
	e1:SetCountLimit(1,id)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--(2) banish this card from your GY; add 1 "Harpie" or "Amazoness" monster from your GY or banishment to your hand
	--(a Trap's GY effect is Spell Speed 2, so a free-chain Quick Effect, cf. Angelechy Disturbance)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id+o)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
	--can be activated the turn it was Set while you control a "Harpie Lady" monster or "Amazoness" monster
	--(condition-only form, no cost, cf. Artmage Impasto -Recapture-)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,2))
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetCondition(s.actcon)
	c:RegisterEffect(e3)
end
--(1)
--TYPE_MONSTER guard: "Harpie" (0x64) and "Amazoness" (0x4) Spells/Traps carry the setcode too
function s.spfilter(c,e,tp)
	return c:IsSetCard(0x64,0x4) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
--any monster on the field, either side, face-up or face-down (cf. Blackwing - Zonda the Dusk); the summon
--comes first, so a free Main Monster Zone is needed even when targeting your own monster
--(cf. Dragonmaid Send-Off / Tearlaments Kitkallos)
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	--the summon does not depend on the target, so it happens even if the target is gone; "and if you do":
	--return the target only after a successful summon, no BreakEffect (cf. Tearlaments Kitkallos)
	if #g>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 and tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
--(2)
--IsFaceupEx: face-down banished cards are excluded (cf. Artmage Movement -Pedigree-); Extra Deck monsters are not
--excluded, as in every corpus "add 1 ... monster from your GY to your hand" (cf. Amazoness Hall / Monster Reincarnation)
function s.thfilter(c)
	return c:IsFaceupEx() and c:IsSetCard(0x64,0x4) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE+LOCATION_REMOVED)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
--activate in the Set turn
--"Harpie Lady" monster: a monster with "Harpie Lady" in its name. "Harpie Lady 1/2/3" and "Cyber Harpie Lady" are aliases of
--"Harpie Lady" and the "name becomes "Harpie Lady"" monsters are 76812113 on the field/GY; the rest are listed by code:
--"Harpie Lady Sisters", "Toon Harpie Lady", "Cyber Slash Harpie Lady", the "Harpie Lady - " customs,
--"Harpie Lady - Elegant Egotist" (pre-release 100459003), "Harpie Lady - Alluring Dance" and
--"Triangle Ecstasy Harpie Lady Sisters" (keep this list in sync across the IMPH scripts)
function s.hlmfilter(c)
	return c:IsCode(76812113,12206212,64116319,63261835,99810010,99810020,99810030,100459003,101403008,101403033)
end
--face-up only: a face-down monster has no name (cf. Artmage Impasto -Recapture-)
function s.actfilter(c)
	return c:IsFaceup() and (s.hlmfilter(c) or c:IsSetCard(0x4))
end
function s.actcon(e)
	return Duel.IsExistingMatchingCard(s.actfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
