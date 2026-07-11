--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Gemini Soldier  (ID: 68366996)
-- Type: Monster / Effect / Gemini
-- Attribute: WIND
-- Race: Warrior
-- Level: 2
-- ATK 500 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the Graveyard.
-- While this card is face-up on the field, you can Normal Summon it to have it be treated as an Effect
-- Monster with this effect:
-- ● Once per turn, if this card would be destroyed by battle, it is not destroyed.
-- If this card battles, after damage calculation, you can Special Summon 1 Level 4 or lower Gemini
-- monster from your Deck, except "Gemini Soldier".
--[[ __CARD_HEADER_END__ ]]

--デュアル・ソルジャー
function c68366996.initial_effect(c)
	aux.EnableDualAttribute(c)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCondition(aux.IsDualState)
	e1:SetCountLimit(1)
	e1:SetValue(c68366996.valcon)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(68366996,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(aux.IsDualState)
	e2:SetTarget(c68366996.target)
	e2:SetOperation(c68366996.operation)
	c:RegisterEffect(e2)
end
function c68366996.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c68366996.filter(c,e,tp)
	return not c:IsCode(68366996) and c:IsLevelBelow(4) and c:IsType(TYPE_DUAL) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c68366996.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c68366996.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c68366996.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c68366996.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
