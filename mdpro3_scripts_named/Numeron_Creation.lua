--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Numeron Creation  (ID: 46382143)
-- Type: Spell
-- Setcode: 0x14a, 0x107b
-- Scope: OCG / TCG
--
-- Effect Text:
-- (This card is always treated as a "Galaxy-Eyes" card.)
-- If 3 or more LIGHT Dragon monsters with 3000 or more original ATK are on the field: Special Summon 1
-- "Number" Dragon Xyz Monster from your Extra Deck, then attach this card on the field to it as
-- material.
-- You can only apply this effect of "Numeron Creation" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ヌメロン・クリエイション
function c46382143.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c46382143.condition)
	e1:SetTarget(c46382143.target)
	e1:SetOperation(c46382143.activate)
	c:RegisterEffect(e1)
end
function c46382143.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_DRAGON) and c:GetBaseAttack()>=3000 and c:IsFaceup()
end
function c46382143.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c46382143.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)>=3
end
function c46382143.spfilter(c,e,tp)
	return c:IsSetCard(0x48) and c:IsRace(RACE_DRAGON) and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c46382143.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,46382143)==0
		and Duel.IsExistingMatchingCard(c46382143.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c46382143.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,46382143)~=0 then return end
	Duel.RegisterFlagEffect(tp,46382143,RESET_PHASE+PHASE_END,0,1)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c46382143.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 and tc:IsLocation(LOCATION_MZONE)
		and c:IsLocation(LOCATION_ONFIELD) and c:IsRelateToEffect(e) and c:IsCanOverlay() then
		Duel.BreakEffect()
		c:CancelToGrave()
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
