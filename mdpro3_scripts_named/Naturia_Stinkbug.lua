--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 自然椿象  (ID: 25866285)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Insect
-- Level 3
-- ATK 200 | DEF 500
-- Setcode: 42
--
-- Effect Text:
-- 自己场上表侧表示存在的名字带有「自然」的怪兽成为攻击对象时，把自己场上表侧表示存在的这张卡送去墓地才能发动。那次攻击无效，战斗阶段结束。
--[[ __CARD_HEADER_END__ ]]

--ナチュル・スティンクバグ
function c25866285.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25866285,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c25866285.condition)
	e1:SetCost(c25866285.cost)
	e1:SetOperation(c25866285.operation)
	c:RegisterEffect(e1)
end
function c25866285.condition(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return ec:IsFaceup() and ec:IsControler(tp) and ec:IsSetCard(0x2a)
end
function c25866285.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c25866285.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
	end
end
