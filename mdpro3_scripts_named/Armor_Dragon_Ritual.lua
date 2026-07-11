--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Armor Dragon Ritual  (ID: 58827995)
-- Type: Spell / Ritual
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is used to Ritual Summon "Knight of Armor Dragon".
-- You must also Tribute monsters from your hand or field whose total Levels equal 4 or more.
-- During your Main Phase, except the turn this card was sent to the GY: You can banish monsters from
-- your hand or face-up field whose total Levels equal 4 or more; banish this card from your GY, and if
-- you do, Special Summon 1 "Knight of Armor Dragon" from your GY.
-- You can only use this effect of "Armor Dragon Ritual" once per turn.
--[[ __CARD_HEADER_END__ ]]

--鎧竜降臨
function c58827995.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,75901113)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,58827995)
	e1:SetCondition(aux.exccon)
	e1:SetCost(c58827995.spcost)
	e1:SetTarget(c58827995.sptg)
	e1:SetOperation(c58827995.spop)
	c:RegisterEffect(e1)
end
function c58827995.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost() and c:IsLevelAbove(1) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup())
end
function c58827995.fselect(g,tp)
	Duel.SetSelectedCard(g)
	return g:CheckWithSumGreater(Card.GetLevel,4) and aux.mzctcheck(g,tp)
end
function c58827995.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE+LOCATION_HAND,0)
	local sg=g:Filter(c58827995.cfilter,nil)
	if chk==0 then return sg:CheckSubGroup(c58827995.fselect,1,sg:GetCount(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=sg:SelectSubGroup(tp,c58827995.fselect,false,1,sg:GetCount(),tp)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c58827995.spfilter(c,e,tp)
	return c:IsCode(75901113) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c58827995.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and Duel.IsExistingMatchingCard(c58827995.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c58827995.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.Remove(c,POS_FACEUP,REASON_EFFECT)~=0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c58827995.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
