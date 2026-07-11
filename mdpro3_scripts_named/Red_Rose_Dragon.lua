--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Red Rose Dragon  (ID: 26118970)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Dragon
-- Level: 3
-- ATK 1000 | DEF 1800
-- Setcode: 0x1123
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is sent to the GY as Synchro Material: You can Special Summon 1 "Rose Dragon" monster
-- from your hand or Deck, except "Red Rose Dragon", then, if it was sent for the Synchro Summon of
-- "Black Rose Dragon" or a Plant Synchro Monster, you can also add 1 "Frozen Rose" or 1 "Blooming of
-- the Darkest Rose" from your Deck to your hand.
-- You can only use this effect of "Red Rose Dragon" once per turn.
--[[ __CARD_HEADER_END__ ]]

--レッドローズ・ドラゴン
function c26118970.initial_effect(c)
	aux.AddCodeList(c,73580471)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26118970,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCountLimit(1,26118970)
	e1:SetCondition(c26118970.spcon)
	e1:SetTarget(c26118970.sptg)
	e1:SetOperation(c26118970.spop)
	c:RegisterEffect(e1)
end
function c26118970.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
end
function c26118970.spfilter(c,e,tp)
	return c:IsSetCard(0x1123) and not c:IsCode(26118970) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c26118970.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c26118970.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
	local rc=e:GetHandler():GetReasonCard()
	if rc and (rc:IsCode(73580471) or (rc:IsRace(RACE_PLANT) and rc:IsType(TYPE_SYNCHRO))) then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_SEARCH+CATEGORY_TOHAND)
		e:SetLabel(1)
	else
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e:SetLabel(0)
	end
end
function c26118970.thfilter(c)
	return c:IsCode(53503015,99092624) and c:IsAbleToHand()
end
function c26118970.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c26118970.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if #g>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 and e:GetLabel()==1
		and Duel.IsExistingMatchingCard(c26118970.thfilter,tp,LOCATION_DECK,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(26118970,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g2=Duel.SelectMatchingCard(tp,c26118970.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if #g2>0 then
			Duel.SendtoHand(g2,tp,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g2)
		end
	end
end
