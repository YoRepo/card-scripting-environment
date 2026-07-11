--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Dimension Wall  (ID: 67095270)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only when an opponent's monster declares an attack.
-- Instead of you, your opponent takes the Battle Damage you would have taken from this battle.
--[[ __CARD_HEADER_END__ ]]

--ディメンション・ウォール
function c67095270.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c67095270.condition)
	e1:SetOperation(c67095270.activate)
	c:RegisterEffect(e1)
end
function c67095270.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c67095270.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
