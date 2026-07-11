--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Masquerade the Blazing Dragon  (ID: 6855503)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level: 8
-- ATK 2500 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Despia" monster + 1 LIGHT or DARK monster
-- While you control this Fusion Summoned card, your opponent must pay 600 LP to activate cards or
-- effects.
-- If your opponent controls a Ritual, Fusion, Synchro, Xyz, or Link Monster, while this card is in
-- your GY (Quick Effect): You can Special Summon this card, but banish it when it leaves the field.
-- You can only use this effect of "Masquerade the Blazing Dragon" once per turn.
--[[ __CARD_HEADER_END__ ]]

--赫灼竜マスカレイド
function c6855503.initial_effect(c)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x164),c6855503.matfilter,true)
	--activate cost
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_ACTIVATE_COST)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetCondition(c6855503.costcon)
	e1:SetCost(c6855503.costchk)
	e1:SetOperation(c6855503.costop)
	c:RegisterEffect(e1)
	--accumulate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_FLAG_EFFECT+6855503)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCondition(c6855503.costcon)
	e2:SetTargetRange(0,1)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6855503,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetCountLimit(1,6855503)
	e3:SetCondition(c6855503.spcon)
	e3:SetTarget(c6855503.sptg)
	e3:SetOperation(c6855503.spop)
	c:RegisterEffect(e3)
end
function c6855503.matfilter(c)
	return c:IsFusionAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK)
end
function c6855503.costcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c6855503.costchk(e,te_or_c,tp)
	local ct=Duel.GetFlagEffect(tp,6855503)
	return Duel.CheckLPCost(tp,ct*600)
end
function c6855503.costop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,600)
end
function c6855503.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL+TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK)
end
function c6855503.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c6855503.cfilter,tp,0,LOCATION_MZONE,1,nil)
end
function c6855503.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c6855503.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1)
	end
	Duel.SpecialSummonComplete()
end
