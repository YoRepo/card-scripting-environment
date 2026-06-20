--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 环状列石术  (ID: 86555018)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上的名字带有「先史遗产」的怪兽被战斗或者卡的效果破坏送去墓地时才能发动。从卡组把1只4星以下的名字带有「先史遗产」的怪兽表侧守备表示特殊召唤。这个效果特殊召唤的怪兽不能把表示形式变更。
--[[ __CARD_HEADER_END__ ]]

--ストーンヘンジ・メソッド
function c86555018.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c86555018.condition)
	e1:SetTarget(c86555018.target)
	e1:SetOperation(c86555018.operation)
	c:RegisterEffect(e1)
end
function c86555018.cfilter(c,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsSetCard(0x70) and c:IsType(TYPE_MONSTER)
end
function c86555018.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c86555018.cfilter,1,nil,tp)
end
function c86555018.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x70) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c86555018.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c86555018.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c86555018.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c86555018.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1,true)
	end
	Duel.SpecialSummonComplete()
end
