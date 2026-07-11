--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Wind-Up Magician  (ID: 59297550)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Spellcaster
-- Level: 4
-- ATK 600 | DEF 1800
-- Setcode: 0x58
-- Scope: OCG / TCG
--
-- Effect Text:
-- If the effect of a "Wind-Up" monster is activated, except "Wind-Up Magician": You can Special Summon
-- 1 Level 4 or lower "Wind-Up" monster from your Deck in face-up Defense Position.
-- This effect can only be used once while this card is face-up on the field.
--[[ __CARD_HEADER_END__ ]]

--ゼンマイマジシャン
function c59297550.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(59297550,0))
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1)
	e1:SetCondition(c59297550.spcon)
	e1:SetTarget(c59297550.sptg)
	e1:SetOperation(c59297550.spop)
	c:RegisterEffect(e1)
end
function c59297550.spcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER)
		and re:GetHandler():IsSetCard(0x58) and not re:GetHandler():IsCode(59297550)
end
function c59297550.filter(c,e,tp)
	return c:IsSetCard(0x58) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c59297550.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsStatus(STATUS_CHAINING)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c59297550.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c59297550.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c59297550.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
