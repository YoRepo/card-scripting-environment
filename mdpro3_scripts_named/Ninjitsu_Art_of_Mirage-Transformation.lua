--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 忍法 妖变化之术  (ID: 63626024)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 97
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：把自己场上1只「忍者」怪兽解放，以对方墓地1只怪兽为对象才能把这张卡发动。那只怪兽在自己场上特殊召唤。这个效果特殊召唤的怪兽在这张卡表侧表示存在期间，也当作「忍者」怪兽使用。这张卡从场上离开时那只
-- 怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--忍法 妖変化の術
function c63626024.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,63626024+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c63626024.cost)
	e1:SetTarget(c63626024.target)
	e1:SetOperation(c63626024.activate)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c63626024.desop)
	c:RegisterEffect(e2)
	--add setcode
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_TARGET)
	e3:SetCode(EFFECT_ADD_SETCODE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetValue(0x2b)
	c:RegisterEffect(e3)
end
function c63626024.cfilter(c)
	return c:IsSetCard(0x2b)
end
function c63626024.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c63626024.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c63626024.cfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c63626024.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c63626024.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c63626024.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c63626024.spfilter,tp,0,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c63626024.spfilter,tp,0,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c63626024.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		c:SetCardTarget(tc)
	end
	Duel.SpecialSummonComplete()
end
function c63626024.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end
