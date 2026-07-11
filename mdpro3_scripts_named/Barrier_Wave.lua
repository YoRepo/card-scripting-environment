--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Barrier Wave  (ID: 96700602)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate by Tributing 1 Synchro Monster when an opponent's monster declares an attack.
-- Change all Attack Position monsters your opponent controls to Defense Position.
-- Then, inflict damage to your opponent equal to the attacking monster's DEF.
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
