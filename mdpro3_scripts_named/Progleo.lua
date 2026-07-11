--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Progleo  (ID: 52615248)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Cyberse
-- Link Rating: 2
-- Link Arrows: Left, Right
-- ATK 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 monsters, except Tokens
-- During your Main Phase, if you control this Link Summoned card: You can banish this card and 1 of
-- your monsters this card points to, then target 1 Link Monster in either GY; Special Summon it, but
-- banish it when it leaves the field.
-- You can only use this effect of "Progleo" once per turn.
--[[ __CARD_HEADER_END__ ]]

--プログレオ
function c52615248.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.NOT(aux.FilterBoolFunction(Card.IsLinkType,TYPE_TOKEN)),2,2)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(52615248,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,52615248)
	e1:SetCondition(c52615248.spcon)
	e1:SetCost(c52615248.spcost)
	e1:SetTarget(c52615248.sptg)
	e1:SetOperation(c52615248.spop)
	c:RegisterEffect(e1)
end
function c52615248.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c52615248.costfilter(c,tp,mc)
	local lg=mc:GetLinkedGroup()
	return lg:IsContains(c) and c:IsAbleToRemoveAsCost() and Duel.GetMZoneCount(tp,Group.FromCards(c,mc))>0
end
function c52615248.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c52615248.costfilter,tp,LOCATION_MZONE,0,1,c,tp,c)
		and c:IsAbleToRemoveAsCost() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c52615248.costfilter,tp,LOCATION_MZONE,0,1,1,c,tp,c)
	g:AddCard(c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c52615248.spfilter(c,e,tp)
	return c:IsType(TYPE_LINK) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c52615248.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c52615248.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c52615248.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c52615248.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c52615248.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		tc:RegisterEffect(e1,true)
	end
	Duel.SpecialSummonComplete()
end
