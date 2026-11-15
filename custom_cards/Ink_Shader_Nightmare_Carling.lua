--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-15T00:00:00
-- Card: Ink Shader Nightmare Carling  (ID: 99811050)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Illusion
-- Level 8
-- ATK 1950 | DEF 2600
-- Setcode: 0x960 (Ink Shader)
--
-- Materials: 1 Tuner + "Ink Shader Carling"
--
-- Effect Text:
-- You can only use the ①③ effects of "Ink Shader Nightmare Carling" once per turn each.
-- ① During the Main Phase (Quick Effect): You can Fusion Summon 1 "Ink-Shaded" Fusion Monster from your
-- Extra Deck, by placing Fusion materials from either field in their owners' Spell/Trap Zones face-up
-- as Continuous Spells.
-- ② Gains 1 Level for each of your banished "Ink-Shade" Spells/Traps.
-- ③ If an "Ink Shader" or "Ink-Shade" Fusion Monster leaves the field because of an opponent's card
-- while this card is in your Spell/Trap Zone: You can Special Summon this card, then you can negate the
-- effects of 1 face-up card your opponent controls.
--[[ __CARD_HEADER_END__ ]]

--Ink Shader Nightmare Carling
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddMaterialCodeList(c,99811000)
	--synchro summon: 1 Tuner + "Ink Shader Carling" (cf. Life Stream Dragon)
	aux.AddSynchroProcedure(c,nil,aux.FilterBoolFunction(Card.IsCode,99811000),1,1)
	c:EnableReviveLimit()
	--(1) (Quick Effect) during the Main Phase: Fusion Summon 1 "Ink-Shaded" Fusion Monster, placing the materials
	--from either field in their owners' Spell & Trap Zones as Continuous Spells
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.fuscon)
	e1:SetTarget(s.fustg)
	e1:SetOperation(s.fusop)
	c:RegisterEffect(e1)
	--(2) gains 1 Level for each of your banished "Ink-Shade" Spells/Traps (cf. Mecha Phantom Beast Raiten)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_LEVEL)
	e2:SetValue(s.lvval)
	c:RegisterEffect(e2)
	--(3) while in your Spell & Trap Zone: if an "Ink Shader"/"Ink-Shade" Fusion Monster leaves the field because of an
	--opponent's card: Special Summon this card, then you can negate 1 face-up card your opponent controls
	--(cf. Centur-Ion Trudea for a monster's effect in the Spell & Trap Zone, My Friend Purrely for the trigger).
	--"Because of an opponent's card" includes battle, and battle destruction happens in the Damage Step, where a
	--field trigger is only offered if it carries EFFECT_FLAG_DAMAGE_STEP
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,id+o)
	e3:SetCondition(s.spcon)
	e3:SetTarget(s.sptg)
	e3:SetOperation(s.spop)
	c:RegisterEffect(e3)
end
--(1)
function s.fuscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsMainPhase()
end
--a material is placed in its OWNER's Spell & Trap Zone (cf. Snake-Eyes Flamberge Dragon); a Token cannot be placed
function s.plfilter(c,tp)
	local r=LOCATION_REASON_TOFIELD
	if not c:IsControler(c:GetOwner()) then r=LOCATION_REASON_CONTROL end
	return not c:IsType(TYPE_TOKEN) and Duel.GetLocationCount(c:GetOwner(),LOCATION_SZONE,tp,r)>0
end
--your monsters on the field
function s.matfilter1(c,e,tp)
	return c:IsLocation(LOCATION_MZONE) and not c:IsImmuneToEffect(e) and s.plfilter(c,tp)
end
--your opponent's monsters on the field (cf. Yomagna the Fire Phantom)
function s.matfilter2(c,e,tp)
	return c:IsFaceup() and c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e) and s.plfilter(c,tp)
end
function s.getmat(e,tp)
	local mg=Duel.GetFusionMaterial(tp):Filter(s.matfilter1,nil,e,tp)
	local mg2=Duel.GetMatchingGroup(s.matfilter2,tp,0,LOCATION_MZONE,nil,e,tp)
	mg:Merge(mg2)
	return mg
end
--no owner can receive more materials than they have free Spell & Trap Zones
function s.ownfilter(c,p)
	return c:GetOwner()==p
end
function s.fcheck(tp,sg,fc)
	return sg:FilterCount(s.ownfilter,nil,tp)<=Duel.GetLocationCount(tp,LOCATION_SZONE,tp)
		and sg:FilterCount(s.ownfilter,nil,1-tp)<=Duel.GetLocationCount(1-tp,LOCATION_SZONE,tp)
end
function s.fusfilter(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and c:IsSetCard(0x1961) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function s.fustg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=tp
		local mg1=s.getmat(e,tp)
		aux.FCheckAdditional=s.fcheck
		local res=Duel.IsExistingMatchingCard(s.fusfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		aux.FCheckAdditional=nil
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg3=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(s.fusfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg3,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function s.fusop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local chkf=tp
	local mg1=s.getmat(e,tp)
	aux.FCheckAdditional=s.fcheck
	local sg1=Duel.GetMatchingGroup(s.fusfilter,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	aux.FCheckAdditional=nil
	local mg3=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg3=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(s.fusfilter,tp,LOCATION_EXTRA,0,nil,e,tp,mg3,mf,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or ce and not Duel.SelectYesNo(tp,ce:GetDescription())) then
			aux.FCheckAdditional=s.fcheck
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
			aux.FCheckAdditional=nil
			tc:SetMaterial(mat1)
			--place the materials in their owners' Spell & Trap Zones face-up as Continuous Spells
			--(MoveToField takes a card from wherever it is, so one that left the Monster Zone meanwhile is skipped)
			for mc in aux.Next(mat1) do
				if mc:IsLocation(LOCATION_MZONE)
					and Duel.MoveToField(mc,tp,mc:GetOwner(),LOCATION_SZONE,POS_FACEUP,true) then
					local e1=Effect.CreateEffect(c)
					e1:SetCode(EFFECT_CHANGE_TYPE)
					e1:SetType(EFFECT_TYPE_SINGLE)
					e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
					e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
					e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
					mc:RegisterEffect(e1)
				end
			end
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		elseif ce then
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg3,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end
--(2)
--"your banished": face-up cards in your banishment (a face-down banished card has no name)
function s.lvfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x961) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function s.lvval(e,c)
	return Duel.GetMatchingGroupCount(s.lvfilter,c:GetControler(),LOCATION_REMOVED,0,nil)
end
--(3)
--an "Ink Shader" or "Ink-Shade" Fusion Monster: either archetype, as it was on the field. The text names no
--controller, so either player's counts; "because of an opponent's card" is the reason player (battle or effect)
function s.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP)
		and c:GetPreviousTypeOnField()&TYPE_FUSION~=0 and c:IsPreviousSetCard(0x960,0x961)
		and c:GetReasonPlayer()==1-tp and not c:IsReason(REASON_RULE)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToChain() or Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==0 then return end
	--"then you can": negate the effects of 1 face-up card your opponent controls (no duration: while it stays face-up)
	local g=Duel.GetMatchingGroup(aux.NegateAnyFilter,tp,0,LOCATION_ONFIELD,nil)
	if #g==0 or not Duel.SelectYesNo(tp,aux.Stringid(id,2)) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
	local sg=g:Select(tp,1,1,nil)
	local tc=sg:GetFirst()
	Duel.HintSelection(sg)
	Duel.BreakEffect()
	Duel.NegateRelatedChain(tc,RESET_TURN_SET)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetValue(RESET_TURN_SET)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e2)
	if tc:IsType(TYPE_TRAPMONSTER) then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e3)
	end
end
