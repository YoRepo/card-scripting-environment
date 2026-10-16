--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-10-16T00:00:00
-- Card: Elegant Tri-Mirror  (ID: 101403053)
-- Type: Spell / Normal
--
-- Effect Text:
-- You can only use the ①st and ②nd effects of this card's name each once per turn.
-- ① Add 1 "Harpie" monster from your Deck to your hand, then if only your opponent controls a
-- monster, you can Special Summon 1 "Harpie Lady", or 1 monster that mentions it, from your hand or
-- GY.
-- ② You can banish this card from your GY; Fusion Summon 1 EARTH or WIND Fusion Monster from your
-- Extra Deck, using monsters from your hand or field.
--[[ __CARD_HEADER_END__ ]]

--Elegant Tri-Mirror
local s,id,o=GetID()
function s.initial_effect(c)
	--names "Harpie Lady" and a "Harpie" monster (house convention: one call each)
	aux.AddCodeList(c,76812113)
	aux.AddSetNameMonsterList(c,0x64)
	--(1) add 1 "Harpie" monster from your Deck to your hand, then if only your opponent controls a monster, you can
	--Special Summon 1 "Harpie Lady", or 1 monster that mentions it, from your hand or GY
	--(the optional GY summon gets no operation info, so it is flagged by category, cf. Mitsurugi Prayers)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	--"use the (1)st effect ... once per turn": a plain count code, not OATH (cf. Fiendsmith's Tract)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
	--(2) banish this card from your GY; Fusion Summon 1 EARTH or WIND Fusion Monster from your Extra Deck,
	--using monsters from your hand or field (a Spell's GY effect is an Ignition Effect, cf. Fiendsmith's Tract)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id+o)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.fsptg)
	e2:SetOperation(s.fspop)
	c:RegisterEffect(e2)
end
s.fusion_effect=true
--(1)
function s.thfilter(c)
	return c:IsSetCard(0x64) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
--"Harpie Lady", or 1 monster that mentions it: "Harpie Lady" (incl. its aliases "Harpie Lady 1/2/3" and
--"Cyber Harpie Lady") is 76812113. Monsters that name it register it, through aux.AddCodeList or, for the
--"name becomes "Harpie Lady"" ones, aux.EnableChangeCode; "Birdface" and "Harpie's Pet Dragon" name it but
--register nothing, so they are listed by code. TYPE_MONSTER guard: Spells/Traps that mention it register
--76812113 too (cf. New Frontier)
function s.spfilter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and (c:IsCode(76812113,45547649,52040216) or aux.IsCodeListed(c,76812113))
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	--"then": only if the monster was added (cf. Fiendsmith's Tract / Ground Xeno)
	if tc and Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
		--"if only your opponent controls a monster": checked now, after the add, face-down monsters included
		--(cf. Rescue-ACE Quick Attacker; not an activation-time snapshot like Cubic Ascension's "controlled")
		if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(s.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp)
			and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
--(2)
--the same Fusion Summon block as Amazoness Spellcaster - Forbidden Spell Dance, which has the same wording (cf. Elzette,
--Azamina of the White Forest): "hand or field" is GetFusionMaterial's default (hand + Monster Zone), immune materials are
--dropped in the activation check too, and the Chain Material branch is kept (cf. Fiendsmith's Tract).
--EARTH or WIND is one attribute mask (IsAttribute tests any bit, cf. Firestorms Over Atlantis)
function s.fmfilter(c,e)
	return not c:IsImmuneToEffect(e)
end
function s.fsfilter(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and c:IsAttribute(ATTRIBUTE_EARTH+ATTRIBUTE_WIND) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function s.fsptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=tp
		local mg1=Duel.GetFusionMaterial(tp):Filter(s.fmfilter,nil,e)
		local res=Duel.IsExistingMatchingCard(s.fsfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(s.fsfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function s.fspop(e,tp,eg,ep,ev,re,r,rp)
	local chkf=tp
	local mg1=Duel.GetFusionMaterial(tp):Filter(s.fmfilter,nil,e)
	local sg1=Duel.GetMatchingGroup(s.fsfilter,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(s.fsfilter,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
	end
	if #sg1>0 or (sg2~=nil and #sg2>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		--no Fusion Summon without materials: a cancelled material selection goes back to the monster choice (cf. Elzette)
		::cancel::
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or ce and not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
			if #mat1==0 then goto cancel end
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		elseif ce~=nil then
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
			if #mat2==0 then goto cancel end
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end
