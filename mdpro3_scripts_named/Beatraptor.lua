--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Beatraptor  (ID: 46924949)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level: 4
-- ATK 1400 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Negate the effects of monsters in the Extra Monster Zones while this card is in the Main Monster
-- Zone.
-- When this card is destroyed by battle: You can Special Summon 1 "Beatraptor" from your Deck.
-- You can only use this effect of "Beatraptor" once per turn.
--[[ __CARD_HEADER_END__ ]]

--縄張恐竜
function c46924949.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCondition(c46924949.discon)
	e1:SetTarget(c46924949.distg)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCountLimit(1,46924949)
	e2:SetTarget(c46924949.sptg)
	e2:SetOperation(c46924949.spop)
	c:RegisterEffect(e2)
end
function c46924949.discon(e)
	return e:GetHandler():GetSequence()<5
end
function c46924949.distg(e,c)
	return c:GetSequence()>4
end
function c46924949.spfilter(c,e,tp)
	return c:IsCode(46924949) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c46924949.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c46924949.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c46924949.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c46924949.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
