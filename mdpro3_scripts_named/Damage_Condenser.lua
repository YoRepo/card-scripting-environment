--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 伤害电容器  (ID: 28378427)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己受到战斗伤害时，丢弃1张手卡才能发动。持有那个时候受到的伤害数值以下的攻击力的1只怪兽从卡组攻击表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ダメージ・コンデンサー
function c28378427.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c28378427.condition)
	e1:SetCost(c28378427.cost)
	e1:SetTarget(c28378427.target)
	e1:SetOperation(c28378427.activate)
	c:RegisterEffect(e1)
end
function c28378427.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c28378427.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c28378427.filter(c,e,tp,dam)
	return c:IsAttackBelow(dam) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
end
function c28378427.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c28378427.filter,tp,LOCATION_DECK,0,1,nil,e,tp,ev) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c28378427.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c28378427.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp,ev)
	if g:GetCount()~=0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
