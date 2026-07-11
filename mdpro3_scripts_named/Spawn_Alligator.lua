--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Spawn Alligator  (ID: 39984786)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Reptile
-- Level: 5
-- ATK 2200 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- During the End Phase of the turn this card was Tribute Summoned by Tributing a Reptile-Type monster:
-- Target 1 monster that was used for the Tribute Summon of this card; Special Summon it from the
-- Graveyard.
--[[ __CARD_HEADER_END__ ]]

--スパウン・アリゲーター
function c39984786.initial_effect(c)
	--tribute check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c39984786.valcheck)
	c:RegisterEffect(e1)
end
function c39984786.valcheck(e,c)
	local g=c:GetMaterial()
	local tc=g:GetFirst()
	local sp=false
	while tc do
		if tc:IsRace(RACE_REPTILE) then
			tc:RegisterFlagEffect(39984786,RESET_EVENT+0x17a0000+RESET_PHASE+PHASE_END,0,1)
			sp=true
		end
		tc=g:GetNext()
	end
	if sp then
		--spsummon
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(39984786,0))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCountLimit(1)
		e1:SetTarget(c39984786.sptg)
		e1:SetOperation(c39984786.spop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD-RESET_TURN_SET+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c39984786.filter(c,e,tp)
	return c:GetFlagEffect(39984786)~=0 and c:IsCanBeEffectTarget(e) and c:IsLocation(LOCATION_GRAVE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c39984786.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return e:GetHandler():GetMaterial():IsContains(chkc) and c39984786.filter(chkc,e,tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local mg=e:GetHandler():GetMaterial()
	local g=mg:FilterSelect(tp,c39984786.filter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c39984786.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
