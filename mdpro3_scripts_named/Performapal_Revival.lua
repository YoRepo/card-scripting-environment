--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 娱乐伙伴复活  (ID: 5672432)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 159
--
-- Effect Text:
-- ①：自己场上的怪兽被战斗·效果破坏的场合才能发动。从自己的手卡·墓地选1只「娱乐伙伴」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--EMリバイバル
function c5672432.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c5672432.condition)
	e1:SetTarget(c5672432.target)
	e1:SetOperation(c5672432.operation)
	c:RegisterEffect(e1)
end
function c5672432.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(tp)
end
function c5672432.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c5672432.cfilter,1,nil,tp)
end
function c5672432.filter(c,e,tp)
	return c:IsSetCard(0x9f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c5672432.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c5672432.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c5672432.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c5672432.filter),tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
