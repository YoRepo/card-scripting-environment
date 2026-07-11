--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Gravekeeper's Nobleman  (ID: 85646474)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 3
-- ATK 1000 | DEF 1000
-- Setcode: 0x2e
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card you control is destroyed by battle with an opponent's attacking monster and sent to
-- your Graveyard: You can Special Summon 1 "Gravekeeper's" monster from your Deck in face-down Defense
-- Position, except "Gravekeeper's Nobleman".
--[[ __CARD_HEADER_END__ ]]

--墓守の使徒
function c85646474.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(85646474,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c85646474.condition)
	e1:SetTarget(c85646474.target)
	e1:SetOperation(c85646474.operation)
	c:RegisterEffect(e1)
end
function c85646474.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE)
		and c:IsPreviousControler(tp) and c==Duel.GetAttackTarget() and Duel.GetAttacker():IsControler(1-tp)
end
function c85646474.filter(c,e,tp)
	return c:IsSetCard(0x2e) and not c:IsCode(85646474) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function c85646474.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c85646474.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c85646474.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c85646474.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(1-tp,g)
	end
end
