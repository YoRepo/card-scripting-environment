--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-10-16T00:00:00
-- Card: Amazoness Spellcaster - Forbidden Spell Dance  (ID: 101403007)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 3
-- ATK 400 | DEF 800
-- Setcode: 0x4 (Amazoness)
--
-- Effect Text:
-- You can only use the ①st, ②nd, and ③rd effects of this card's name each once per turn.
-- ① If this card is Normal or Special Summoned: You can add 1 "Amazoness" monster from your Deck to
-- your hand, except a Level 3 monster.
-- ② During your Main Phase: You can Fusion Summon 1 EARTH or WIND Fusion Monster from your Extra
-- Deck, using monsters from your hand or field.
-- ③ During damage calculation, if your "Amazoness" monster battles an opponent's monster: You can
-- banish this card from your GY; swap the battling monsters' ATK until the end of this turn.
--[[ __CARD_HEADER_END__ ]]

--Amazoness Spellcaster - Forbidden Spell Dance
local s,id,o=GetID()
function s.initial_effect(c)
	--(1) if Normal or Special Summoned: add 1 "Amazoness" monster from your Deck to your hand, except a Level 3 monster
	--(both registrations share one count code, cf. Kewl Tune Reco / Amazoness Princess)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--(2) during your Main Phase: Fusion Summon 1 EARTH or WIND Fusion Monster, using monsters from your hand or field
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,id+o)
	e3:SetTarget(s.fsptg)
	e3:SetOperation(s.fspop)
	c:RegisterEffect(e3)
	--(3) during damage calculation, if your "Amazoness" monster battles an opponent's monster: banish this card
	--from your GY; swap the battling monsters' ATK until the end of this turn
	--(a GY monster effect in damage calculation is a Quick Effect even without the label: every corpus monster
	--GY damage-calc effect is QUICK_O, cf. Destiny HERO - Dreamer (unlabeled); cost and "battles an opponent's
	--monster" shape cf. Cross Debug)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,2))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCountLimit(1,id+o*2)
	e4:SetCondition(s.atkcon)
	e4:SetCost(aux.bfgcost)
	e4:SetOperation(s.atkop)
	c:RegisterEffect(e4)
end
s.fusion_effect=true
--(1)
--"Amazoness" monster (Amazoness Spells/Traps share the setcode) that is not Level 3 (cf. Kewl Tune Reco)
function s.thfilter(c)
	return c:IsSetCard(0x4) and c:IsType(TYPE_MONSTER) and not c:IsLevel(3)
		and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
--(2)
--standard Fusion Summon boilerplate, cf. Elzette, Azamina of the White Forest (same wording): "hand or field" is
--GetFusionMaterial's default (hand + Monster Zone); this card may be a material but need not be, so no relate check.
--EARTH or WIND is one attribute mask (IsAttribute tests any bit, cf. Predaplant Bufolicula / Desert Twister)
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
--(3)
--your face-up "Amazoness" monster (any position, attacking or attacked, either turn) battling an opponent's
--monster; a direct attack has no opponent's monster (cf. Amazoness Golden Whip Master, Spright Pixies)
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a,d=Duel.GetBattleMonster(tp)
	return a and d and a:IsFaceup() and a:IsSetCard(0x4)
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	--re-fetched by current controller: a control change in the chain leaves one side nil (cf. Spright Pixies);
	--a swap needs both monsters still in the battle and face-up (cf. Amazoness Spellcaster, TA.I. Strike)
	local a,d=Duel.GetBattleMonster(tp)
	if not (a and d and a:IsRelateToBattle() and d:IsRelateToBattle() and a:IsFaceup() and d:IsFaceup()) then return end
	--"ATK", not "original ATK": current values, read before either changes so the swap is simultaneous;
	--two separate effects, as in Amazoness Spellcaster (current ATK swap -> EFFECT_SET_ATTACK_FINAL,
	--cf. Performage Mirror Conductor)
	local atk1=a:GetAttack()
	local atk2=d:GetAttack()
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(atk2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	a:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_ATTACK_FINAL)
	e2:SetValue(atk1)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	d:RegisterEffect(e2)
end
