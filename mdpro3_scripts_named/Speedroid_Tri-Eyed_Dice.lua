--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 疾行机人 三目骰子  (ID: 27660735)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Machine
-- Level 3
-- ATK 300 | DEF 1500
-- Setcode: 8214
--
-- Effect Text:
-- ①：对方回合把墓地的这张卡除外才能发动。这个回合，对方怪兽的攻击只有1次无效。
--[[ __CARD_HEADER_END__ ]]

--SR三つ目のダイス
function c27660735.initial_effect(c)
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27660735,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_ATTACK)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c27660735.condition)
	e1:SetCost(aux.bfgcost)
	e1:SetOperation(c27660735.operation)
	c:RegisterEffect(e1)
end
function c27660735.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and aux.bpcon(e,tp,eg,ep,ev,re,r,rp)
end
function c27660735.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttacker() then Duel.NegateAttack()
	else
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_ATTACK_ANNOUNCE)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetOperation(c27660735.disop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c27660735.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,27660735)
	Duel.NegateAttack()
end
