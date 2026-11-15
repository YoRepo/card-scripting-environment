--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-15T00:00:00
-- Card: Ink-Shaded Deity Carling  (ID: 99811070)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Illusion
-- Level 12
-- ATK 2950 | DEF 2950
-- Setcode: 0x1961 (Ink-Shaded), 0x960 (Ink Shader)
--
-- Materials: 1 "Ink Shader" monster + 4 monsters (EARTH, WATER, FIRE, WIND)
--
-- Effect Text:
-- (This card is always treated as an "Ink Shader" card.) Must first be either Fusion Summoned, or
-- Special Summoned (from your Extra Deck) by sending 1 Level 12 "Ink Shader" monster you control to the
-- GY. You can only Special Summon "Ink-Shaded Deity Carling" once per turn.
-- ① Once per turn, during your opponent's Main Phase (Quick Effect): You can apply 1 of the following
-- effects (but you can only use each effect once per turn):
-- ● Xyz Summon 1 "Ink-Shaded Masterpiece" monster from your Extra Deck using this card you control.
-- ● Send 1 Spell/Trap from the field to the GY; Special Summon 1 Level 7 or lower "Ink-Shaded" Fusion
-- Monster from your Extra Deck.
--[[ __CARD_HEADER_END__ ]]

--Ink-Shaded Deity Carling
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--you can only Special Summon "Ink-Shaded Deity Carling" once per turn (any method: no "this way")
	c:SetSPSummonOnce(id)
	--fusion material: 1 "Ink Shader" monster + 1 EARTH + 1 WATER + 1 FIRE + 1 WIND monster
	aux.AddFusionProcMix(c,false,true,
		aux.FilterBoolFunction(Card.IsFusionSetCard,0x960),
		aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_EARTH),
		aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_WATER),
		aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_FIRE),
		aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_WIND))
	--must first be Fusion Summoned, or Special Summoned by the procedure below (only gated in the Extra Deck)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(s.splimit)
	c:RegisterEffect(e0)
	--SS proc (from Extra Deck): send 1 Level 12 "Ink Shader" monster you control to the GY
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--(1) once per turn, (Quick Effect) during your opponent's Main Phase: apply 1 of 2 effects (each once per turn)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e2:SetCountLimit(1)
	e2:SetCondition(s.effcon)
	e2:SetTarget(s.efftg)
	e2:SetOperation(s.effop)
	c:RegisterEffect(e2)
end
--Summoning Condition (from the Extra Deck: Fusion Summon, or the SS proc below, which the engine does not check against this)
function s.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or aux.fuslimit(e,se,sp,st)
end
--SS proc (send 1 Level 12 "Ink Shader" monster you control to the GY)
function s.spcfilter(c,tp,sc)
	return c:IsFaceup() and c:IsSetCard(0x960) and c:IsLevel(12) and c:IsAbleToGraveAsCost()
		and Duel.GetLocationCountFromEx(tp,tp,c,sc)>0
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(s.spcfilter,tp,LOCATION_MZONE,0,1,nil,tp,c)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(s.spcfilter,tp,LOCATION_MZONE,0,nil,tp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local tc=e:GetLabelObject()
	Duel.SendtoGrave(tc,REASON_SPSUMMON)
end
--(1)
function s.effcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp and Duel.IsMainPhase()
end
--● Xyz Summon using this card you control: the Xyz Monster's own procedure must accept this card alone
--(cf. K9-ØØ Lupis)
function s.xyzfilter(c,mg)
	return c:IsSetCard(0x3961) and c:IsXyzSummonable(mg,1,1)
end
--● cost: 1 Spell/Trap from either field
function s.costfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGraveAsCost()
end
--the Level 7 or lower "Ink-Shaded" Fusion Monsters all carry "Must either be Fusion Summoned, or Special Summoned
--... by sending 1 Spell/Trap from the field to the GY while you control a Level N or higher "Ink Shader" monster",
--which is exactly what this effect does: it summons them through that condition (nocheck), like
--Crimsonheart Revelation summoning Crimsonheart Hidden Infant. Their once-per-turn limit still applies
function s.spfilter(c,e,tp)
	return c:IsType(TYPE_FUSION) and c:IsSetCard(0x1961) and c:IsLevelBelow(7)
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
--the option is chosen, and its cost paid, on activation (cf. Mitsurugi Magatama)
function s.efftg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local b1=Duel.GetFlagEffect(tp,id)==0
		and Duel.IsExistingMatchingCard(s.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,Group.FromCards(c))
	local b2=Duel.GetFlagEffect(tp,id+o)==0
		and (not e:IsCostChecked()
			or Duel.IsExistingMatchingCard(s.costfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil))
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp)
	if chk==0 then return b1 or b2 end
	local op=aux.SelectFromOptions(tp,
		{b1,aux.Stringid(id,1),1},
		{b2,aux.Stringid(id,2),2})
	e:SetLabel(op)
	if op==1 then
		Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
	elseif op==2 then
		Duel.RegisterFlagEffect(tp,id+o,RESET_PHASE+PHASE_END,0,1)
		if e:IsCostChecked() then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local g=Duel.SelectMatchingCard(tp,s.costfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
			Duel.SendtoGrave(g,REASON_COST)
		end
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function s.effop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==1 then
		if not c:IsRelateToChain() or c:IsFacedown() or c:IsControler(1-tp) then return end
		local mg=Group.FromCards(c)
		local g=Duel.GetMatchingGroup(s.xyzfilter,tp,LOCATION_EXTRA,0,nil,mg)
		if #g==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sc=g:Select(tp,1,1,nil):GetFirst()
		Duel.XyzSummon(tp,sc,mg,1,1)
	elseif e:GetLabel()==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
		if #g>0 then
			Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
		end
	end
end
