--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Guardragon Elpy  (ID: 86148577)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Dragon
-- Link Rating: 1
-- Link Arrows: Left
-- ATK 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Level 4 or lower Dragon monster
-- You cannot Special Summon monsters, except Dragon monsters.
-- During your Main Phase: You can Special Summon 1 Dragon monster from your hand or Deck to your zone
-- that 2 or more Link Monsters point to.
-- You can only use this effect of "Guardragon Elpy" once per turn.
-- You can only Special Summon "Guardragon Elpy(s)" once per turn.
--[[ __CARD_HEADER_END__ ]]

--守護竜エルピィ
function c86148577.initial_effect(c)
	c:SetSPSummonOnce(86148577)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c86148577.matfilter,1,1)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c86148577.splimit)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(86148577,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,86148577)
	e2:SetTarget(c86148577.sptg)
	e2:SetOperation(c86148577.spop)
	c:RegisterEffect(e2)
end
function c86148577.matfilter(c)
	return c:IsLevelBelow(4) and c:IsLinkRace(RACE_DRAGON)
end
function c86148577.splimit(e,c,sump,sumtype,sumpos,targetp)
	return not c:IsRace(RACE_DRAGON)
end
function c86148577.lkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_LINK)
end
function c86148577.spfilter(c,e,tp,zone)
	return c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone)
end
function c86148577.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local zone=aux.GetMultiLinkedZone(tp)
	if chk==0 then return Duel.IsExistingMatchingCard(c86148577.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp,zone) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c86148577.spop(e,tp,eg,ep,ev,re,r,rp)
	local zone=aux.GetMultiLinkedZone(tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c86148577.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp,zone)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end
