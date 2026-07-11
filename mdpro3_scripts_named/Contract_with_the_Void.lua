--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Contract with the Void  (ID: 19828680)
-- Type: Spell
-- Setcode: 0xc5
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you have 3 or more other cards in your hand: Discard your entire hand, then you can Special
-- Summon 1 "Infernity" monster or 1 Level 8 DARK Dragon Synchro Monster from your GY.
--[[ __CARD_HEADER_END__ ]]

--煉獄の契約
function c19828680.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES_SELF+CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c19828680.condition)
	e1:SetTarget(c19828680.target)
	e1:SetOperation(c19828680.activate)
	c:RegisterEffect(e1)
end
function c19828680.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())>=3
end
function c19828680.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local exc=nil
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) and e:GetHandler():IsLocation(LOCATION_HAND) then exc=e:GetHandler() end
	local sg=Duel.GetMatchingGroup(nil,tp,LOCATION_HAND,0,exc)
	if chk==0 then return sg:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES_SELF,sg,sg:GetCount(),0,0)
end
function c19828680.spfilter(c,e,tp)
	return (c:IsSetCard(0xb) or c:IsType(TYPE_SYNCHRO) and c:IsLevel(8) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsRace(RACE_DRAGON))
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c19828680.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if g:GetCount()>0 and Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)~=0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(c19828680.spfilter),tp,LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.SelectYesNo(tp,aux.Stringid(19828680,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c19828680.spfilter),tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
