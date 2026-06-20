--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 通向进化的吊桥  (ID: 93504463)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上存在的怪兽被选择作为攻击对象时才能发动。选择自己墓地存在的1只名字带有「进化虫」的怪兽特殊召唤，把攻击对象转换为那只怪兽进行伤害计算。
--[[ __CARD_HEADER_END__ ]]

--進化への懸け橋
function c93504463.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c93504463.condition)
	e1:SetTarget(c93504463.target)
	e1:SetOperation(c93504463.activate)
	c:RegisterEffect(e1)
end
function c93504463.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp)
end
function c93504463.spfilter(c,e,tp)
	return c:IsSetCard(0x304e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c93504463.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c93504463.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c93504463.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c93504463.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c93504463.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local a=Duel.GetAttacker()
		if a:IsAttackable() and not a:IsImmuneToEffect(e) then
			Duel.CalculateDamage(a,tc)
		end
	end
end
