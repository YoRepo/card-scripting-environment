--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Brotherhood of the Fire Fist - Spirit  (ID: 1662004)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level: 3
-- ATK 500 | DEF 200
-- Setcode: 0x79
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be used as Synchro Material, except for the Synchro Summon of a Beast-Warrior monster.
-- When this card is Normal Summoned: You can target 1 Level 3 FIRE monster with 200 or less DEF in
-- your GY; Special Summon that target in Defense Position, and if you do, monsters you control cannot
-- attack for the rest of this turn, except Beast-Warrior monsters.
-- You can only use this effect of "Brotherhood of the Fire Fist - Spirit" once per turn.
--[[ __CARD_HEADER_END__ ]]

--炎星師－チョウテン
function c1662004.initial_effect(c)
	--synchro limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(c1662004.synlimit)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1662004,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,1662004)
	e2:SetTarget(c1662004.sptg)
	e2:SetOperation(c1662004.spop)
	c:RegisterEffect(e2)
end
function c1662004.synlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_BEASTWARRIOR)
end
function c1662004.spfilter(c,e,tp)
	return c:IsDefenseBelow(200) and c:IsAttribute(ATTRIBUTE_FIRE) and c:IsLevel(3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c1662004.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c1662004.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c1662004.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c1662004.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c1662004.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsAttribute(ATTRIBUTE_FIRE) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetTarget(c1662004.atktg)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c1662004.atktg(e,c)
	return not c:IsRace(RACE_BEASTWARRIOR)
end
