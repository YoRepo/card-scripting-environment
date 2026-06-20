--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 速攻稻草人  (ID: 18964575)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：对方回合的直接攻击宣言时，把这张卡从手卡丢弃才能发动。那次攻击无效。那之后，战斗阶段结束。
--[[ __CARD_HEADER_END__ ]]

--速攻のかかし
function c18964575.initial_effect(c)
	--end battle phase
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(18964575,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c18964575.condition)
	e1:SetCost(c18964575.cost)
	e1:SetOperation(c18964575.operation)
	c:RegisterEffect(e1)
end
function c18964575.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c18964575.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c18964575.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		Duel.BreakEffect()
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
	end
end
