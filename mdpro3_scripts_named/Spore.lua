--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Spore  (ID: 11747708)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Plant
-- Level: 1
-- ATK 400 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is in your GY: You can banish 1 other Plant monster from your GY; Special Summon this
-- card, and if you do, increase its Level by the Level of that banished monster.
-- You can only use this effect of "Spore" once per Duel.
--[[ __CARD_HEADER_END__ ]]

--スポーア
function c11747708.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11747708,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,11747708+EFFECT_COUNT_CODE_DUEL)
	e1:SetCost(c11747708.cost)
	e1:SetTarget(c11747708.target)
	e1:SetOperation(c11747708.operation)
	c:RegisterEffect(e1)
end
function c11747708.costfilter(c)
	return c:IsRace(RACE_PLANT) and c:GetLevel()>0 and c:IsAbleToRemoveAsCost()
end
function c11747708.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11747708.costfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c11747708.costfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(g:GetFirst():GetLevel())
end
function c11747708.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c11747708.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==1 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
