--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Naturia Rock  (ID: 54161401)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 3
-- ATK 1200 | DEF 1200
-- Setcode: 0x2a
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per Chain, when a Trap Card is activated (Quick Effect): You can send the top card of your Deck
-- to the GY; Special Summon this card from your hand.
--[[ __CARD_HEADER_END__ ]]

--ナチュル・ロック
function c54161401.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54161401,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c54161401.spcon)
	e1:SetCost(c54161401.spcost)
	e1:SetTarget(c54161401.sptg)
	e1:SetOperation(c54161401.spop)
	c:RegisterEffect(e1)
end
function c54161401.spcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsType(TYPE_TRAP)
end
function c54161401.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeckAsCost(tp,1) end
	Duel.DiscardDeck(tp,1,REASON_COST)
end
function c54161401.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c54161401.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
