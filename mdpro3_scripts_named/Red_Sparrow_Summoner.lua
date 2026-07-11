--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Red Sparrow Summoner  (ID: 81354330)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Spellcaster
-- Level: 4
-- ATK 1600 | DEF 1300
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card you control is destroyed by battle with an opponent's attacking monster and sent to
-- your Graveyard: You can Special Summon 1 Warrior-Type monster with 1500 or less ATK from your Deck
-- in Attack Position.
--[[ __CARD_HEADER_END__ ]]

--朱雀の召喚士
function c81354330.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81354330,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c81354330.condition)
	e1:SetTarget(c81354330.target)
	e1:SetOperation(c81354330.operation)
	c:RegisterEffect(e1)
end
function c81354330.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
		and Duel.GetAttacker():IsControler(1-tp)
end
function c81354330.filter(c,e,tp)
	return c:IsAttackBelow(1500) and c:IsRace(RACE_WARRIOR) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
end
function c81354330.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c81354330.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c81354330.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c81354330.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
