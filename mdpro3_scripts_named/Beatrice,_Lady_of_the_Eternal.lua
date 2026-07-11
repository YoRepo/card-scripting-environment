--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Beatrice, Lady of the Eternal  (ID: 27552504)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Fairy
-- Rank: 6
-- ATK 2500 | DEF 2800
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 6 monsters
-- You can also Xyz Summon this card by sending 1 "Burning Abyss" monster from your hand to the GY,
-- then using 1 "Dante" monster you control as material.
-- (Transfer its materials to this card.)
-- If Summoned this way, the following effect cannot be activated this turn.
-- Once per turn (Quick Effect): You can detach 1 material from this card; send 1 card from your Deck
-- to the GY.
-- If this card in your possession is destroyed by your opponent's card and sent to your GY: You can
-- Special Summon 1 "Burning Abyss" monster from your Extra Deck, ignoring its Summoning conditions.
--[[ __CARD_HEADER_END__ ]]

--永遠の淑女 ベアトリーチェ
function c27552504.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2,c27552504.ovfilter,aux.Stringid(27552504,0),2,c27552504.xyzop)
	c:EnableReviveLimit()
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27552504,1))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1)
	e1:SetCost(c27552504.tgcost)
	e1:SetTarget(c27552504.tgtg)
	e1:SetOperation(c27552504.tgop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(27552504,2))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c27552504.spcon)
	e2:SetTarget(c27552504.sptg)
	e2:SetOperation(c27552504.spop)
	c:RegisterEffect(e2)
end
function c27552504.cfilter(c)
	return c:IsSetCard(0xb1) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c27552504.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xd5)
end
function c27552504.xyzop(e,tp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c27552504.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c27552504.cfilter,1,1,REASON_COST,nil)
	e:GetHandler():RegisterFlagEffect(27552504,RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END,0,1)
end
function c27552504.tgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c27552504.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(27552504)==0
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c27552504.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c27552504.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousControler(tp) and rp==1-tp and c:IsReason(REASON_DESTROY)
end
function c27552504.spfilter(c,e,tp)
	return c:IsSetCard(0xb1) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c27552504.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c27552504.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c27552504.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c27552504.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
