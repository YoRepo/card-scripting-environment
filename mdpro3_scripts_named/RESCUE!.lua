--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: R救援！  (ID: 99984170)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 395
--
-- Effect Text:
-- 这个卡名在规则上也当作「救援ACE队」卡使用。这个卡名的卡在1回合只能发动1张。
-- ①：以自己墓地1只「救援ACE队」怪兽为对象才能发动（自己场上有「救援ACE队 消防栓」存在的场合，也能作为代替以对方墓地1只怪兽为对象）。那只怪兽在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--RESCUE！
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.spfilter(c,e,tp,check)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and (check and c:IsControler(1-tp) or c:IsSetCard(0x18b) and c:IsControler(tp))
end
function s.checkfilter(c)
	return c:IsCode(37617348) and c:IsFaceup()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local check=Duel.IsExistingMatchingCard(s.checkfilter,tp,LOCATION_ONFIELD,0,1,nil)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and s.spfilter(chkc,e,tp,check) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(s.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp,check) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,s.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp,check)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
