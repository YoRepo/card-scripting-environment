--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-15T00:00:00
-- Card: Ink-Shade Art - Spiritgate  (ID: 99811110)
-- Type: Trap / Normal
-- Setcode: 0x961 (Ink-Shade)
--
-- Effect Text:
-- You can only use 1 "Ink-Shade Art - Spiritgate" effect per turn and only once that turn.
-- ① If you control an "Ink Shader" monster: Place 1 monster your opponent controls in their Spell/Trap
-- Zone face-up as a Continuous Spell.
-- ② If this card is in your GY: You can banish this card, then target 1 "Ink Shader" monster you
-- control; Special Summon 1 "Ink-Shaded" monster from your Extra Deck, whose Level is lower than that
-- target (this is treated as a Fusion Summon).
--[[ __CARD_HEADER_END__ ]]

--Ink-Shade Art - Spiritgate
local s,id,o=GetID()
function s.initial_effect(c)
	--(1) if you control an "Ink Shader" monster: place 1 monster your opponent controls in their Spell & Trap Zone
	--face-up as a Continuous Spell (not targeted: it is chosen on resolution)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--(2) from GY: banish this card, then target 1 "Ink Shader" monster you control; Special Summon 1 "Ink-Shaded"
	--monster from your Extra Deck with a lower Level than it (treated as a Fusion Summon)
	--(shares the once-per-turn with (1); a Trap's effect in the GY is Spell Speed 2: cf. Artmage Pact -Awakening-)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCountLimit(1,id)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
end
--(1)
function s.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x960)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
--a Token cannot be placed as a Continuous Spell
function s.plfilter(c)
	return not c:IsType(TYPE_TOKEN)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_SZONE,tp)>0
		and Duel.IsExistingMatchingCard(s.plfilter,tp,0,LOCATION_MZONE,1,nil) end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_SZONE,tp)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,s.plfilter,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if not tc then return end
	Duel.HintSelection(g)
	--"their Spell/Trap Zone": the zone of the player who controls it (cf. Snake-Eyes Flamberge Dragon for the placement)
	if not tc:IsImmuneToEffect(e) and Duel.MoveToField(tc,tp,1-tp,LOCATION_SZONE,POS_FACEUP,true) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
	end
end
--(2)
--"treated as a Fusion Summon": only a Fusion Monster can be Fusion Summoned, and it must allow a Summon without
--materials (cf. Instant Fusion, Nervedo the Shadebeast Power Patron). An Xyz Monster has no Level to be lower
function s.spfilter(c,e,tp,lv)
	return c:IsType(TYPE_FUSION) and c:IsSetCard(0x1961) and c:IsLevelBelow(lv-1) and c:CheckFusionMaterial()
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function s.tgfilter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x960) and c:IsLevelAbove(2)
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c:GetLevel())
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.tgfilter(chkc,e,tp) end
	if chk==0 then return aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_FMATERIAL)
		and Duel.IsExistingTarget(s.tgfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,s.tgfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToChain() or tc:IsFacedown() then return end
	if not aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_FMATERIAL) then return end
	--the Level is read on resolution
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc:GetLevel())
	local sc=g:GetFirst()
	if not sc then return end
	sc:SetMaterial(nil)
	if Duel.SpecialSummon(sc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)~=0 then
		sc:CompleteProcedure()
	end
end
