--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Bujingi Pavo  (ID: 10860121)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Winged Beast
-- Level: 4
-- ATK 1700 | DEF 800
-- Setcode: 0x88
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a Beast-Warrior-Type "Bujin" monster you control is destroyed by battle and sent to the
-- Graveyard: You can send this card from your hand to the Graveyard; Special Summon 1 "Bujin" monster
-- from your Deck.
-- You can only use the effect of "Bujingi Pavo" once per turn.
--[[ __CARD_HEADER_END__ ]]

--武神器－イオツミ
function c10860121.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10860121,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,10860121)
	e1:SetCondition(c10860121.condition)
	e1:SetCost(c10860121.cost)
	e1:SetTarget(c10860121.target)
	e1:SetOperation(c10860121.operation)
	c:RegisterEffect(e1)
end
function c10860121.cfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR) and c:IsReason(REASON_BATTLE)
end
function c10860121.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10860121.cfilter,1,nil,tp)
end
function c10860121.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c10860121.filter(c,e,tp)
	return c:IsSetCard(0x88) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10860121.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10860121.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)
end
function c10860121.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10860121.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
