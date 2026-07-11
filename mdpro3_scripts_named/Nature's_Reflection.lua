--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Nature's Reflection  (ID: 83467607)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- During this turn, any effect activated by your opponent that would inflict damage becomes an effect
-- that inflicts damage to their Life Points.
--[[ __CARD_HEADER_END__ ]]

--リフレクト・ネイチャー
function c83467607.initial_effect(c)
	--reflect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c83467607.operation)
	c:RegisterEffect(e1)
end
function c83467607.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REFLECT_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c83467607.refcon)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c83467607.refcon(e,re,val,r,rp,rc)
	return re and not re:IsHasType(EFFECT_TYPE_CONTINUOUS) and rp==1-e:GetOwnerPlayer()
end
