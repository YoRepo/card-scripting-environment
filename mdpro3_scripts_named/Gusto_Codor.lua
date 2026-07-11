--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Gusto Codor  (ID: 9897998)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 3
-- ATK 1000 | DEF 400
-- Setcode: 0x10
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card destroys an opponent's monster by battle and sends it to the Graveyard: You can
-- Special Summon 1 WIND Psychic-Type monster with 1500 or less DEF from your Deck.
--[[ __CARD_HEADER_END__ ]]

--ガスタ・コドル
function c9897998.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9897998,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c9897998.condition)
	e1:SetTarget(c9897998.target)
	e1:SetOperation(c9897998.operation)
	c:RegisterEffect(e1)
end
function c9897998.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return c:IsRelateToBattle() and ((a==c and d:IsLocation(LOCATION_GRAVE) and d:IsType(TYPE_MONSTER))
		or (d==c and a:IsLocation(LOCATION_GRAVE) and a:IsType(TYPE_MONSTER)))
end
function c9897998.filter(c,e,tp)
	return c:IsDefenseBelow(1500) and c:IsRace(RACE_PSYCHO) and c:IsAttribute(ATTRIBUTE_WIND)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c9897998.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c9897998.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c9897998.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g = Duel.SelectMatchingCard(tp,c9897998.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
