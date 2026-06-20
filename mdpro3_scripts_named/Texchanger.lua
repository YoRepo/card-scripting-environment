--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 纹理转换蛙  (ID: 74210057)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Cyberse
-- Level 1
-- ATK 100 | DEF 100
--
-- Effect Text:
-- ①：1回合1次，自己怪兽被选择作为攻击对象时才能发动。那次攻击无效。那之后，从自己的手卡·卡组·墓地选1只电子界族通常怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--テクスチェンジャー
function c74210057.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c74210057.condition)
	e1:SetTarget(c74210057.target)
	e1:SetOperation(c74210057.operation)
	c:RegisterEffect(e1)
end
function c74210057.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget() and Duel.GetAttackTarget():IsControler(tp)
end
function c74210057.filter(c,e,tp)
	return c:IsRace(RACE_CYBERSE) and c:IsType(TYPE_NORMAL) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c74210057.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c74210057.filter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c74210057.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.NegateAttack() or Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c74210057.filter),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
