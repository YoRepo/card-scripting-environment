--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Armed Dragon LV3  (ID: 980973)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level: 3
-- ATK 1200 | DEF 900
-- Setcode: 0x41, 0x111
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your Standby Phase: You can send this card to the GY; Special Summon 1 "Armed Dragon LV5"
-- from your hand or Deck.
--[[ __CARD_HEADER_END__ ]]

--アームド・ドラゴン LV3
function c980973.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(980973,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCondition(c980973.spcon)
	e1:SetCost(c980973.spcost)
	e1:SetTarget(c980973.sptg)
	e1:SetOperation(c980973.spop)
	c:RegisterEffect(e1)
end
c980973.lvup={46384672}
function c980973.spcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c980973.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c980973.spfilter(c,e,tp)
	return c:IsCode(46384672) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c980973.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c980973.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c980973.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c980973.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
