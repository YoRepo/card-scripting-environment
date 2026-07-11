--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Saint Azamina  (ID: 85065943)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Illusion
-- Level: 10
-- ATK 0 | DEF 4000
-- Setcode: 0x1bc
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 6 or higher monsters (1 Fusion + 1 Synchro)
-- Your opponent cannot target cards in their field, GY, or banishment, or this card on the field, with
-- card effects.
-- Your opponent takes any battle damage you would have taken.
-- If this card was Fusion Summoned this turn (Quick Effect): You can Special Summon 1 Level 9 or lower
-- "Azamina" monster from your Deck or Extra Deck.
-- You can only use this effect of "Saint Azamina" once per turn.
--[[ __CARD_HEADER_END__ ]]

--聖アザミナ
local s,id,o=GetID()
function s.initial_effect(c)
	--material
	aux.AddFusionProcFun2(c,s.mfilter1,s.mfilter2,true)
	c:EnableReviveLimit()
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED)
	e1:SetTarget(s.efftg)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
	--reflect battle damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,0)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,id)
	e3:SetCondition(s.spcon)
	e3:SetTarget(s.sptg)
	e3:SetOperation(s.spop)
	c:RegisterEffect(e3)
end
s.material_type=TYPE_SYNCHRO
function s.mfilter1(c)
	return c:IsLevelAbove(6) and c:IsFusionType(TYPE_FUSION)
end
function s.mfilter2(c)
	return c:IsLevelAbove(6) and c:IsFusionType(TYPE_SYNCHRO)
end
function s.efftg(e,c)
	return c==e:GetHandler() or c:GetControler()~=e:GetHandlerPlayer()
end
function s.spcon(e,tp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
		and e:GetHandler():IsStatus(STATUS_SPSUMMON_TURN)
end
function s.spfilter(c,e,tp)
	return c:IsSetCard(0x1bc) and c:IsLevelBelow(9)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and (c:IsLocation(LOCATION_DECK) and Duel.GetMZoneCount(tp)>0
			or c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_EXTRA)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
