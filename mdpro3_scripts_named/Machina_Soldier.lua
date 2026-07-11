--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Machina Soldier  (ID: 60999392)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 4
-- ATK 1600 | DEF 1500
-- Setcode: 0x36
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned while you control no other monsters: You can Special Summon 1
-- "Machina" monster from your hand, except "Machina Soldier".
--[[ __CARD_HEADER_END__ ]]

--マシンナーズ・ソルジャー
function c60999392.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60999392,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c60999392.sumcon)
	e1:SetTarget(c60999392.sumtg)
	e1:SetOperation(c60999392.sumop)
	c:RegisterEffect(e1)
end
function c60999392.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==1
end
function c60999392.filter(c,e,tp)
	return c:IsSetCard(0x36) and not c:IsCode(60999392) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c60999392.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c60999392.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c60999392.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c60999392.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
