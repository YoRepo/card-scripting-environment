--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Gagaga Academy Emergency Network  (ID: 21715135)
-- Type: Spell
-- Setcode: 0x54
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls a monster and you control no monsters: Special Summon 1 "Gagaga" monster
-- from your Deck.
-- You cannot Special Summon any other monsters the turn you activate this card, except by Xyz Summon.
-- You can only activate 1 "Gagaga Academy Emergency Network" per turn.
--[[ __CARD_HEADER_END__ ]]

--ガガガ学園の緊急連絡網
function c21715135.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,21715135+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c21715135.condition)
	e1:SetCost(c21715135.cost)
	e1:SetTarget(c21715135.target)
	e1:SetOperation(c21715135.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(21715135,ACTIVITY_SPSUMMON,c21715135.counterfilter)
end
function c21715135.counterfilter(c)
	return c:IsSummonType(SUMMON_TYPE_XYZ)
end
function c21715135.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0 and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c21715135.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(21715135,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetLabelObject(e)
	e1:SetTarget(c21715135.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c21715135.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return sumtype~=SUMMON_TYPE_XYZ and e:GetLabelObject()~=se
end
function c21715135.filter(c,e,tp)
	return c:IsSetCard(0x54) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c21715135.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c21715135.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c21715135.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c21715135.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
