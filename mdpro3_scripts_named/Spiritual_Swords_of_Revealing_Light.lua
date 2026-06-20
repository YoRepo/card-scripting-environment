--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 光之护封灵剑  (ID: 78625592)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：对方怪兽的攻击宣言时1次，支付1000基本分才能发动。那次攻击无效。
-- ②：对方回合把墓地的这张卡除外才能发动。这个回合，对方怪兽不能直接攻击。
--[[ __CARD_HEADER_END__ ]]

--光の護封霊剣
function c78625592.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--disable attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(78625592,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c78625592.condition)
	e2:SetCost(c78625592.cost)
	e2:SetOperation(c78625592.operation)
	c:RegisterEffect(e2)
	--cannot direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(78625592,1))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,TIMING_ATTACK)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCondition(c78625592.grcondition)
	e3:SetCost(aux.bfgcost)
	e3:SetOperation(c78625592.groperation)
	c:RegisterEffect(e3)
end
function c78625592.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c78625592.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c78625592.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c78625592.grcondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and aux.bpcon(e,tp,eg,ep,ev,re,r,rp)
end
function c78625592.groperation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
