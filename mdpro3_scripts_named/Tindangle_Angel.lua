--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Tindangle Angel  (ID: 68860936)
-- Type: Monster / Effect / Flip
-- Attribute: DARK
-- Race: Fiend
-- Level: 4
-- ATK 500 | DEF 1800
-- Setcode: 0x10b
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: You can Special Summon 1 Flip monster from your hand or GY in face-down Defense Position,
-- except "Tindangle Angel", then, if it is your opponent's Battle Phase, end the Battle Phase.
-- You can only use this effect of "Tindangle Angel" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ティンダングル・エンジェル
function c68860936.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68860936,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,68860936)
	e1:SetTarget(c68860936.target)
	e1:SetOperation(c68860936.operation)
	c:RegisterEffect(e1)
end
function c68860936.filter(c,e,tp)
	return c:IsType(TYPE_FLIP) and not c:IsCode(68860936) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function c68860936.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c68860936.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c68860936.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c68860936.filter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(1-tp,g)
	end
	local ph=Duel.GetCurrentPhase()
	if tp~=Duel.GetTurnPlayer() and ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
	end
end
