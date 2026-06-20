--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 龙骑兵团-黑枪龙  (ID: 13361027)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Dragon
-- Level 3
-- ATK 1000 | DEF 1000
-- Setcode: 41
--
-- Effect Text:
-- ①：1回合1次，把自己场上1只龙族「龙骑兵团」怪兽解放，以自己墓地1只4星以下的鸟兽族怪兽为对象才能发动。那只鸟兽族怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ドラグニティ－ブラックスピア
function c13361027.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13361027,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c13361027.cost)
	e1:SetTarget(c13361027.target)
	e1:SetOperation(c13361027.operation)
	c:RegisterEffect(e1)
end
function c13361027.cfilter(c,tp)
	return c:IsSetCard(0x29) and c:IsRace(RACE_DRAGON)
		and Duel.GetMZoneCount(tp,c)>0 and (c:IsControler(tp) or c:IsFaceup())
end
function c13361027.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c13361027.cfilter,1,nil,tp) end
	local rg=Duel.SelectReleaseGroup(tp,c13361027.cfilter,1,1,nil,tp)
	Duel.Release(rg,REASON_COST)
end
function c13361027.filter(c,e,sp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_WINDBEAST) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c13361027.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c13361027.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c13361027.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c13361027.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c13361027.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsRace(RACE_WINDBEAST) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
