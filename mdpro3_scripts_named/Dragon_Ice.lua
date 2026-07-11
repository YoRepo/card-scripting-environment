--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Dragon Ice  (ID: 64262809)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Dragon
-- Level: 5
-- ATK 1800 | DEF 2200
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent Special Summons a monster (except during the Damage Step): You can discard 1
-- card; Special Summon this card from your hand or Graveyard.
-- There can only be 1 "Dragon Ice" on the field.
--[[ __CARD_HEADER_END__ ]]

--ドラゴン・アイス
function c64262809.initial_effect(c)
	c:SetUniqueOnField(1,1,64262809)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64262809,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c64262809.spcon)
	e1:SetCost(c64262809.spcost)
	e1:SetTarget(c64262809.sptg)
	e1:SetOperation(c64262809.spop)
	c:RegisterEffect(e1)
end
function c64262809.cfilter(c,tp)
	return c:IsSummonPlayer(1-tp)
end
function c64262809.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c64262809.cfilter,1,nil,tp)
end
function c64262809.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local exc=(c:IsLocation(LOCATION_HAND) and not c:IsAbleToGraveAsCost()) and c or nil
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,exc) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,exc)
end
function c64262809.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c64262809.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() or (c:IsLocation(LOCATION_GRAVE) and c:IsPreviousLocation(LOCATION_HAND) and c:GetReasonEffect()==e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
