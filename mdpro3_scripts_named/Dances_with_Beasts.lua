--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Dances with Beasts  (ID: 33298291)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When an opponent's monster declares a direct attack, while the combined ATK of all face-up monsters
-- they control is 8000 or higher: Special Summon 3 monsters with different original names in Attack
-- Position, 1 each from your hand, Deck, and GY.
-- You can only activate 1 "Dances with Beasts" per turn.
--[[ __CARD_HEADER_END__ ]]

--獣湧き肉躍り
function c33298291.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1,33298291+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c33298291.condition)
	e1:SetTarget(c33298291.target)
	e1:SetOperation(c33298291.activate)
	c:RegisterEffect(e1)
end
function c33298291.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local atk=g:GetSum(Card.GetAttack)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil and atk>=8000
end
function c33298291.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
end
function c33298291.fcheck(c,g)
	return g:IsExists(Card.IsOriginalCodeRule,1,c,c:GetOriginalCodeRule())
end
function c33298291.fselect(g)
	return g:GetClassCount(Card.GetLocation)==g:GetCount() and not g:IsExists(c33298291.fcheck,1,nil,g)
end
function c33298291.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c33298291.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,nil,e,tp)
	if chk==0 then return g:CheckSubGroup(c33298291.fselect,3,3) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c33298291.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<3 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c33298291.spfilter),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:SelectSubGroup(tp,c33298291.fselect,false,3,3)
	if sg and sg:GetCount()==3 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
