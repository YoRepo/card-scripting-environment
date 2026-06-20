--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 截敌蛋  (ID: 75078585)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己场上的怪兽被战斗·效果破坏送去墓地的场合才能发动。从自己的手卡·卡组·墓地选1只「小走鹃」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--スクランブル・エッグ
function c75078585.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(c75078585.condition)
	e1:SetTarget(c75078585.target)
	e1:SetOperation(c75078585.operation)
	c:RegisterEffect(e1)
end
function c75078585.cfilter(c,tp)
	return c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(tp)
end
function c75078585.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c75078585.cfilter,1,nil,tp)
end
function c75078585.filter(c,e,tp)
	return c:IsCode(36472900) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75078585.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75078585.filter,tp,0x13,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c75078585.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c75078585.filter),tp,0x13,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
