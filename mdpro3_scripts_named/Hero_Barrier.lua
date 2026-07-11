--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Hero Barrier  (ID: 44676200)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your opponent's turn: You can activate this card; during the Battle Step, any opponent's
-- attack that takes place while you control an "Elemental HERO" monster is negated, but this effect
-- only works once.
--[[ __CARD_HEADER_END__ ]]

--ヒーローバリア
function c44676200.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c44676200.condition)
	e1:SetOperation(c44676200.operation)
	c:RegisterEffect(e1)
end
function c44676200.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3008)
end
function c44676200.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and aux.bpcon(e,tp,eg,ep,ev,re,r,rp)
end
function c44676200.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttacker() and c44676200.discon(e,tp,eg,ep,ev,re,r,rp) then
		Duel.NegateAttack()
	else
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_ATTACK_ANNOUNCE)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetCondition(c44676200.discon)
		e1:SetOperation(c44676200.disop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c44676200.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44676200.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c44676200.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,44676200)
	Duel.NegateAttack()
end
