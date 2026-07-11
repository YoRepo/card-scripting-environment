--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Garbage Collector  (ID: 11801343)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Cyberse
-- Level: 2
-- ATK 100 | DEF 1900
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can target 1 other Cyberse monster you control that began the Duel in the Main Deck; return it
-- to the hand, and if you do, Special Summon from your Deck 1 Cyberse monster with the same Level, but
-- with a different name.
-- You can only use this effect of "Garbage Collector" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ガベージコレクター
function c11801343.initial_effect(c)
	--bounce and summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11801343,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,11801343)
	e1:SetTarget(c11801343.target)
	e1:SetOperation(c11801343.operation)
	c:RegisterEffect(e1)
end
function c11801343.thfilter(c,e,tp)
	return c:IsFaceup() and c:IsRace(RACE_CYBERSE) and c:IsAbleToHand()
		and Duel.GetMZoneCount(tp,c)>0 and c:GetOriginalType()&TYPE_MONSTER>0 and not c:IsType(TYPE_TOKEN)
		and Duel.IsExistingMatchingCard(c11801343.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,c)
end
function c11801343.spfilter(c,e,tp,tc)
	return c:IsRace(RACE_CYBERSE) and c:IsLevel(tc:GetLevel())
		and not c:IsCode(tc:GetCode()) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c11801343.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c11801343.thfilter(chkc,e,tp) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c11801343.thfilter,tp,LOCATION_MZONE,0,1,c,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c11801343.thfilter,tp,LOCATION_MZONE,0,1,1,c,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c11801343.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToChain() and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c11801343.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,tc)
		if g:GetCount()~=0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
