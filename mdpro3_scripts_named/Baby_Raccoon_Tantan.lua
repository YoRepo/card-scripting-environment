--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Baby Raccoon Tantan  (ID: 28118128)
-- Type: Monster / Effect / Flip
-- Attribute: EARTH
-- Race: Beast
-- Level: 2
-- ATK 0 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Special Summon 1 Level 2 Beast-Type monster from your Deck, except "Baby Raccoon Tantan".
--[[ __CARD_HEADER_END__ ]]

--子狸たんたん
function c28118128.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(28118128,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c28118128.target)
	e1:SetOperation(c28118128.operation)
	c:RegisterEffect(e1)
end
function c28118128.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c28118128.filter(c,e,tp)
	return not c:IsCode(28118128) and c:IsLevel(2) and c:IsRace(RACE_BEAST)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c28118128.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c28118128.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
