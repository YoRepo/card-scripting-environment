--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 波动障壁  (ID: 96700602)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方怪兽的攻击宣言时，把自己场上存在的1只同调怪兽解放发动。对方场上攻击表示存在的怪兽全部变成守备表示。那之后，给与对方基本分攻击宣言的怪兽的守备力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--波動障壁
function c96700602.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c96700602.condition)
	e1:SetCost(c96700602.cost)
	e1:SetTarget(c96700602.target)
	e1:SetOperation(c96700602.operation)
	c:RegisterEffect(e1)
end
function c96700602.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c96700602.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsType,1,nil,TYPE_SYNCHRO) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsType,1,1,nil,TYPE_SYNCHRO)
	Duel.Release(g,REASON_COST)
end
function c96700602.filter(c)
	return c:IsAttackPos() and c:IsCanChangePosition()
end
function c96700602.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c96700602.filter,tp,0,LOCATION_MZONE,1,nil) end
	local tc=eg:GetFirst()
	if tc:IsLocation(LOCATION_MZONE) then
		Duel.SetTargetCard(tc)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetDefense())
	end
end
function c96700602.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local g=Duel.GetMatchingGroup(c96700602.filter,tp,0,LOCATION_MZONE,nil)
	if Duel.ChangePosition(g,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,0,0)~=0 then
		if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:GetDefense()>0 then
			Duel.BreakEffect()
			Duel.Damage(1-tp,tc:GetDefense(),REASON_EFFECT)
		end
	end
end
