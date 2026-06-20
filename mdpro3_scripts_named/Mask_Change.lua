--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 假面变化  (ID: 21143940)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 165
--
-- Effect Text:
-- ①：以自己场上1只「英雄」怪兽为对象才能发动。把那只怪兽的属性确认，送去墓地。这个效果让那只怪兽从场上离开的场合，再把持有相同属性的1只「假面英雄」怪兽从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--マスク・チェンジ
function c21143940.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c21143940.target)
	e1:SetOperation(c21143940.activate)
	c:RegisterEffect(e1)
end
function c21143940.tfilter(c,att,e,tp,tc)
	return c:IsSetCard(0xa008) and c:IsAttribute(att)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,true) and Duel.GetLocationCountFromEx(tp,tp,tc,c)>0
end
function c21143940.filter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x8)
		and Duel.IsExistingMatchingCard(c21143940.tfilter,tp,LOCATION_EXTRA,0,1,nil,c:GetAttribute(),e,tp,c)
end
function c21143940.chkfilter(c,att)
	return c:IsFaceup() and c:IsSetCard(0x8) and (c:GetAttribute()&att)==att
end
function c21143940.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c21143940.chkfilter(chkc,e:GetLabel()) end
	if chk==0 then return Duel.IsExistingTarget(c21143940.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c21143940.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	e:SetLabel(g:GetFirst():GetAttribute())
end
function c21143940.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local att=tc:GetAttribute()
	if Duel.SendtoGrave(tc,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c21143940.tfilter,tp,LOCATION_EXTRA,0,1,1,nil,att,e,tp,nil)
	if sg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,0,tp,tp,false,true,POS_FACEUP)
		sg:GetFirst():CompleteProcedure()
	end
end
