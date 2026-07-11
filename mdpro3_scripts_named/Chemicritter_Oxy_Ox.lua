--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Chemicritter Oxy Ox  (ID: 18993198)
-- Type: Monster / Effect / Gemini
-- Attribute: WIND
-- Race: Beast
-- Level: 2
-- ATK 0 | DEF 2100
-- Setcode: 0xeb
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the Graveyard.
-- While this card is a Normal Monster on the field, you can Normal Summon it to have it become an
-- Effect Monster with this effect.
-- ● During your Main Phase: You can Special Summon 1 Gemini monster from your hand, and if you do, all
-- Gemini monsters you currently control become that monster's original Level until the end of this
-- turn.
-- You can only use this effect of "Chemicritter Oxy Ox" once per turn.
--[[ __CARD_HEADER_END__ ]]

--化合獣オキシン・オックス
function c18993198.initial_effect(c)
	aux.EnableDualAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(18993198,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,18993198)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.IsDualState)
	e1:SetTarget(c18993198.sptg)
	e1:SetOperation(c18993198.spop)
	c:RegisterEffect(e1)
end
function c18993198.filter(c,e,tp)
	return c:IsType(TYPE_DUAL) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c18993198.lvfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_DUAL)
end
function c18993198.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c18993198.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c18993198.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c18993198.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) then
		local lv=g:GetFirst():GetOriginalLevel()
		local tg=Duel.GetMatchingGroup(c18993198.lvfilter,tp,LOCATION_MZONE,0,nil)
		local tc=tg:GetFirst()
		while tc do
			if not tc:IsLevel(lv) then
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_CHANGE_LEVEL)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e1:SetValue(lv)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
				tc:RegisterEffect(e1)
			end
			tc=tg:GetNext()
		end
	end
end
