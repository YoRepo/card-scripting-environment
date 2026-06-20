--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 武神逐  (ID: 66727115)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 136
--
-- Effect Text:
-- 把自己场上1只名字带有「武神」的兽战士族怪兽解放才能发动。从自己墓地选择和那只怪兽的卡名不同的1只名字带有「武神」的怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--武神逐
function c66727115.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c66727115.cost)
	e1:SetTarget(c66727115.target)
	e1:SetOperation(c66727115.activate)
	c:RegisterEffect(e1)
end
function c66727115.rfilter(c,e,tp)
	return c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR)
		and Duel.IsExistingTarget(c66727115.spfilter,tp,LOCATION_GRAVE,0,1,nil,c:GetCode(),e,tp)
end
function c66727115.spfilter(c,code,e,tp)
	return c:IsSetCard(0x88) and not c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c66727115.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c66727115.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c66727115.spfilter(chkc,e:GetLabel(),e,tp) end
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroup(tp,c66727115.rfilter,1,nil,e,tp)
	end
	local g=Duel.SelectReleaseGroup(tp,c66727115.rfilter,1,1,nil,e,tp)
	local code=g:GetFirst():GetCode()
	e:SetLabel(code)
	Duel.Release(g,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectTarget(tp,c66727115.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,code,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sg,1,0,0)
end
function c66727115.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
