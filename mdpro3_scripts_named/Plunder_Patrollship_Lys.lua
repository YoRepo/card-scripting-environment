--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Plunder Patrollship Lys  (ID: 18832779)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Fiend
-- Level: 8
-- ATK 2000 | DEF 2000
-- Setcode: 0x13f
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 "Plunder Patroll" monsters
-- During the Main Phase (Quick Effect): You can Special Summon 1 "Plunder Patroll" Monster Card from
-- your hand or face-up Spell & Trap Zone.
-- When your opponent activates a monster effect (Quick Effect): You can discard 1 "Plunder Patroll"
-- card; negate the activation, and if you do, destroy it, then if this card is equipped with a
-- "Plunder Patroll" card, you can add 1 "Plunder Patroll" card from your Deck to your hand.
-- You can only use each effect of "Plunder Patrollship Lys" once per turn.
--[[ __CARD_HEADER_END__ ]]

--海造賊－双翼のリュース号
function c18832779.initial_effect(c)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x13f),2,true)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(18832779,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,18832779)
	e1:SetCondition(c18832779.spcon)
	e1:SetTarget(c18832779.sptg)
	e1:SetOperation(c18832779.spop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(18832779,1))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,18832780)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c18832779.discon)
	e2:SetCost(c18832779.discost)
	e2:SetTarget(c18832779.distg)
	e2:SetOperation(c18832779.disop)
	c:RegisterEffect(e2)
end
function c18832779.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c18832779.spfilter(c,e,tp)
	return c:IsSetCard(0x13f) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c18832779.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c18832779.spfilter,tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_SZONE+LOCATION_HAND)
end
function c18832779.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c18832779.spfilter,tp,LOCATION_SZONE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c18832779.discon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and rp==1-tp
		and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c18832779.discfilter(c)
	return c:IsDiscardable() and c:IsSetCard(0x13f)
end
function c18832779.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c18832779.discfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c18832779.discfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c18832779.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c18832779.eqfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x13f)
end
function c18832779.thfilter(c)
	return c:IsSetCard(0x13f) and c:IsAbleToHand()
end
function c18832779.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re)
		and Duel.Destroy(eg,REASON_EFFECT)>0 and c:IsRelateToEffect(e)
		and c:GetEquipGroup():IsExists(c18832779.eqfilter,1,nil)
		and Duel.IsExistingMatchingCard(c18832779.thfilter,tp,LOCATION_DECK,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(18832779,2)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c18832779.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
