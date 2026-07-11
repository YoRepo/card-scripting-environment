--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Mozarta the Melodious Maestra  (ID: 3395226)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 8
-- ATK 2600 | DEF 2000
-- Setcode: 0x109b
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can Special Summon 1 LIGHT Fairy monster from your hand.
-- You cannot Special Summon other monsters the turn you activate this effect, except for LIGHT
-- monsters.
--[[ __CARD_HEADER_END__ ]]

--幻奏の音姫プロディジー・モーツァルト
function c3395226.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3395226,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c3395226.spcost)
	e1:SetTarget(c3395226.sptg)
	e1:SetOperation(c3395226.spop)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(3395226,ACTIVITY_SPSUMMON,c3395226.counterfilter)
end
function c3395226.counterfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c3395226.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(3395226,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c3395226.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c3395226.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:GetAttribute()~=ATTRIBUTE_LIGHT
end
function c3395226.filter(c,e,tp)
	return c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c3395226.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c3395226.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c3395226.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c3395226.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
