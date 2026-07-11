--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Rokket Tracer  (ID: 68464358)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Dragon
-- Level: 4
-- ATK 1600 | DEF 1000
-- Setcode: 0x102
-- Scope: OCG / TCG
--
-- Effect Text:
-- (Quick Effect): You can target 1 face-up card you control; destroy it, and if you do, Special Summon
-- 1 "Rokket" monster from your Deck, except "Rokket Tracer", also you cannot Special Summon from the
-- Extra Deck for the rest of this turn, except DARK monsters.
-- You can only use this effect of "Rokket Tracer" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ヴァレット・トレーサー
function c68464358.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68464358,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,68464358)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c68464358.sptg)
	e1:SetOperation(c68464358.spop)
	c:RegisterEffect(e1)
end
function c68464358.tgfilter(c,tp)
	return c:IsFaceup() and Duel.GetMZoneCount(tp,c)>0
end
function c68464358.spfilter(c,e,tp)
	return not c:IsCode(68464358) and c:IsSetCard(0x102) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c68464358.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c68464358.tgfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c68464358.tgfilter,tp,LOCATION_ONFIELD,0,1,nil,tp)
		and Duel.IsExistingMatchingCard(c68464358.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c68464358.tgfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c68464358.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c68464358.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c68464358.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c68464358.splimit(e,c)
	return not c:IsAttribute(ATTRIBUTE_DARK) and c:IsLocation(LOCATION_EXTRA)
end
