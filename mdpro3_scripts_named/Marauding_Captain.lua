--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 冲锋陷阵的队长  (ID: 2460565)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 3
-- ATK 1200 | DEF 400
--
-- Effect Text:
-- ①：这张卡召唤成功时才能发动。从手卡把1只4星以下的怪兽特殊召唤。
-- ②：只要这张卡在怪兽区域存在，对方不能选择其他的战士族怪兽作为攻击对象。
--[[ __CARD_HEADER_END__ ]]

--切り込み隊長
function c2460565.initial_effect(c)
	--cannot select battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetValue(c2460565.atlimit)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(2460565,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c2460565.sumtg)
	e2:SetOperation(c2460565.sumop)
	c:RegisterEffect(e2)
end
function c2460565.atlimit(e,c)
	return c~=e:GetHandler() and c:IsFaceup() and c:IsRace(RACE_WARRIOR)
end
function c2460565.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c2460565.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c2460565.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c2460565.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c2460565.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
