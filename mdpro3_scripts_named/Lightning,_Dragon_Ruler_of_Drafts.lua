--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Lightning, Dragon Ruler of Drafts  (ID: 89185742)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level: 3
-- ATK 500 | DEF 1800
-- Setcode: 0x1c4
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can discard this card and 1 Dragon or WIND monster; Special Summon 1 "Tempest, Dragon Ruler of
-- Storms" from your Deck, but it cannot attack this turn.
-- You can only use this effect of "Lightning, Dragon Ruler of Drafts" once per turn.
--[[ __CARD_HEADER_END__ ]]

--風征竜－ライトニング
function c89185742.initial_effect(c)
	aux.AddCodeList(c,89399912)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89185742,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,89185742)
	e1:SetCost(c89185742.spcost)
	e1:SetTarget(c89185742.sptg)
	e1:SetOperation(c89185742.spop)
	c:RegisterEffect(e1)
end
function c89185742.costfilter(c)
	return (c:IsRace(RACE_DRAGON) or c:IsAttribute(ATTRIBUTE_WIND)) and c:IsDiscardable()
end
function c89185742.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable()
		and Duel.IsExistingMatchingCard(c89185742.costfilter,tp,LOCATION_HAND,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,c89185742.costfilter,tp,LOCATION_HAND,0,1,1,c)
	g:AddCard(c)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
end
function c89185742.spfilter(c,e,tp)
	return c:IsCode(89399912) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c89185742.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c89185742.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c89185742.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstMatchingCard(c89185742.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
	Duel.SpecialSummonComplete()
end
