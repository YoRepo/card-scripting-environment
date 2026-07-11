--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Evil★Twin Challenge  (ID: 98360333)
-- Type: Trap
-- Setcode: 0x2151
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 "Ki-sikil" monster or 1 "Lil-la" monster in your GY; Special Summon it, then you can apply
-- the following effect.
-- ● Immediately after this effect resolves, Link Summon 1 "Evil★Twin" Link Monster using monsters you
-- control as material.
-- You can only activate 1 "Evil★Twin Challenge" per turn.
--[[ __CARD_HEADER_END__ ]]

--Evil★Twin チャレンジ
function c98360333.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,98360333+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c98360333.target)
	e1:SetOperation(c98360333.activate)
	c:RegisterEffect(e1)
end
function c98360333.tgfilter(c,e,tp)
	return c:IsSetCard(0x152,0x153) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c98360333.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp)
		and c98360333.tgfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetMZoneCount(tp)>0
		and Duel.IsExistingTarget(c98360333.tgfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c98360333.tgfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c98360333.linkfilter(c)
	return c:IsLinkSummonable(nil) and c:IsSetCard(0x2151)
end
function c98360333.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or Duel.GetMZoneCount(tp)<1
		or Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)==0 then return end
	local g=Duel.GetMatchingGroup(c98360333.linkfilter,tp,LOCATION_EXTRA,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(98360333,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		Duel.LinkSummon(tp,tc,nil)
	end
end
