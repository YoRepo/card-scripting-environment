--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-10-16T00:00:00
-- Card: Harpie & Amazoness Rakshasa Formation  (ID: 101403054)
-- Type: Spell / Quick-Play
-- Setcode: 0x4, 0x64 (Amazoness, Harpie)
--
-- Effect Text:
-- You can only activate 1 card with this card's name per turn.
-- ① Target 1 "Harpie" or "Amazoness" monster in your GY or banishment; Special Summon it, then you
-- can apply 1 of these effects based on the number of "Harpie Lady" monsters and "Amazoness"
-- monsters you control.
-- ● 1+: Place 1 "Eyelluring Mirror Wall" from your Deck face-up in your Spell & Trap Zone.
-- ● 2+: Take control of 1 monster your opponent controls.
-- ● 3+: Destroy all monsters your opponent controls.
--[[ __CARD_HEADER_END__ ]]

--Harpie & Amazoness Rakshasa Formation
local s,id,o=GetID()
function s.initial_effect(c)
	--names "Harpie Lady" and "Eyelluring Mirror Wall" (one call), and a "Harpie" monster (house convention: one call)
	aux.AddCodeList(c,76812113,101403075)
	aux.AddSetNameMonsterList(c,0x64)
	--(1) target 1 "Harpie"/"Amazoness" monster in your GY/banishment; Special Summon it, then you can apply 1 effect
	--based on the number of "Harpie Lady" monsters and "Amazoness" monsters you control
	--(1+: place "Eyelluring Mirror Wall" from the Deck / 2+: take control of 1 opponent's monster / 3+: destroy all theirs)
	--(the optional effects' categories go on the effect itself, with no operation info, cf. Emissaries from Darkness)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_CONTROL+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	--"You can only activate 1 card with this card's name per turn" (cf. Ryzeal Plugin / Ursarctic Slider / Evil Mind)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
--(1)
--"Harpie Lady" monster: a monster with "Harpie Lady" in its name. "Harpie Lady 1/2/3" and "Cyber Harpie Lady" are aliases of
--"Harpie Lady" and the "name becomes "Harpie Lady"" monsters are 76812113 on the field/GY; the rest are listed by code:
--"Harpie Lady Sisters", "Toon Harpie Lady", "Cyber Slash Harpie Lady", the "Harpie Lady - " customs,
--"Harpie Lady - Elegant Egotist" (pre-release 100459003), "Harpie Lady - Alluring Dance" and
--"Triangle Ecstasy Harpie Lady Sisters" (keep this list in sync across the IMPH scripts)
function s.hlmfilter(c)
	return c:IsCode(76812113,12206212,64116319,63261835,99810010,99810020,99810030,100459003,101403008,101403033)
end
--"Harpie" or "Amazoness" monster: IsSetCard is a variadic OR; TYPE_MONSTER because the GY/banishment can hold
--"Harpie"/"Amazoness" Spells/Traps; IsFaceupEx leaves out face-down banished cards (cf. Ryzeal Plugin / Theorealize Overdrive)
function s.spfilter(c,e,tp)
	return c:IsFaceupEx() and c:IsSetCard(0x64,0x4) and c:IsType(TYPE_MONSTER)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
--"your GY or banishment": the chkc form with IsControler (cf. Ursarctic Slider)
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and s.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(s.spfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,s.spfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
--"Harpie Lady" monsters and "Amazoness" monsters you control: face-up (a face-down card cannot be identified),
--each monster counted once even if it is both; a plain "Harpie" monster (e.g. "Harpie's Pet Dragon") does not count
function s.cntfilter(c)
	return c:IsFaceup() and (s.hlmfilter(c) or c:IsSetCard(0x4))
end
--placed, not activated (it is a Continuous Trap): the named card is picked by code, not forbidden; no unique-on-field
--check, since "Eyelluring Mirror Wall" has no SetUniqueOnField (cf. Mudora the Sword Oracle's "Gravekeeper's Trap" filter)
function s.pfilter(c)
	return c:IsCode(101403075) and not c:IsForbidden()
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	--"then": the rest only if the monster was Special Summoned (cf. Ryzeal Plugin)
	if not (tc:IsRelateToEffect(e) and aux.NecroValleyFilter()(tc)
		and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0) then return end
	--counted now, after the summon, so the summoned monster counts itself (cf. Emissaries from Darkness)
	Duel.AdjustAll()
	local ct=Duel.GetMatchingGroupCount(s.cntfilter,tp,LOCATION_MZONE,0,nil)
	--"1 of these effects, based on the number": any tier that is met can be chosen, each checked with >= (cf. Evil Mind)
	local b1=ct>=1 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(s.pfilter,tp,LOCATION_DECK,0,1,nil)
	local b2=ct>=2 and Duel.IsExistingMatchingCard(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil)
	local b3=ct>=3 and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil)
	if not (b1 or b2 or b3) then return end
	--"you can": the last entry applies nothing (cf. Emissaries from Darkness / Corpse-Seller Crow)
	local op=aux.SelectFromOptions(tp,
		{b1,aux.Stringid(id,1)},
		{b2,aux.Stringid(id,2)},
		{b3,aux.Stringid(id,3)},
		{true,aux.Stringid(id,4)})
	if op==1 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local pc=Duel.SelectMatchingCard(tp,s.pfilter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
		if pc then
			Duel.MoveToField(pc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	elseif op==2 then
		Duel.BreakEffect()
		--not targeted, and permanent: the text gives no duration (cf. The Suppression Pluto; Triple Tactics Talent
		--passes PHASE_END,1 only because its text says "until the End Phase")
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
		local g=Duel.SelectMatchingCard(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,1,nil)
		if #g>0 then
			Duel.HintSelection(g)
			Duel.GetControl(g:GetFirst(),tp)
		end
	elseif op==3 then
		Duel.BreakEffect()
		--all, face-down included, not targeted (cf. Raigeki)
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
