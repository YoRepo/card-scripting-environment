--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Valkyrian Knight  (ID: 99348756)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level: 4
-- ATK 1900 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- Monsters your opponent controls cannot target Warrior monsters for attacks, except "Valkyrian
-- Knight".
-- When this card is destroyed by battle and sent to the GY: You can banish this card and 1 Warrior
-- monster from your GY, then target 1 Level 5 or higher Warrior monster in your GY; Special Summon
-- that target.
--[[ __CARD_HEADER_END__ ]]

--バルキリー・ナイト
function c99348756.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c99348756.atktg)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99348756,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c99348756.spcon)
	e2:SetTarget(c99348756.sptg)
	e2:SetOperation(c99348756.spop)
	c:RegisterEffect(e2)
end
function c99348756.atktg(e,c)
	return not c:IsCode(99348756) and c:IsFaceup() and c:IsRace(RACE_WARRIOR)
end
function c99348756.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c99348756.rmfilter(c,e,tp,g)
	return c:IsAbleToRemoveAsCost() and g:IsExists(c99348756.spfilter,1,c,e,tp)
end
function c99348756.spfilter(c,e,tp)
	return c:IsCanBeEffectTarget(e) and c:IsLevelAbove(5) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c99348756.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c99348756.spfilter(chkc,e,tp) end
	local g=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_GRAVE,0,e:GetHandler(),RACE_WARRIOR)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsAbleToRemoveAsCost()
		and g:IsExists(c99348756.rmfilter,1,nil,e,tp,g) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=g:FilterSelect(tp,c99348756.rmfilter,1,1,nil,e,tp,g)
	g:Sub(rg)
	rg:AddCard(e:GetHandler())
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:FilterSelect(tp,c99348756.spfilter,1,1,nil,e,tp)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sg,1,0,0)
end
function c99348756.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsRace(RACE_WARRIOR) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
