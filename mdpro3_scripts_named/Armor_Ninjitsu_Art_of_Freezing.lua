--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Armor Ninjitsu Art of Freezing  (ID: 65150219)
-- Type: Trap / Continuous
-- Setcode: 0x61
-- Scope: OCG / TCG
--
-- Effect Text:
-- When an opponent's monster declares an attack, if you control a "Ninja" monster: You can flip this
-- card face-up; negate that attack and end the Battle Phase.
-- While this card is face-up on the field and you control a "Ninja" monster, monsters your opponent
-- controls cannot change their battle positions.
--[[ __CARD_HEADER_END__ ]]

--機甲忍法フリーズ・ロック
function c65150219.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c65150219.condition)
	e1:SetOperation(c65150219.activate)
	c:RegisterEffect(e1)
	--pos limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c65150219.poscon)
	c:RegisterEffect(e2)
end
function c65150219.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2b)
end
function c65150219.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.IsExistingMatchingCard(c65150219.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c65150219.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
	end
end
function c65150219.poscon(e)
	return Duel.IsExistingMatchingCard(c65150219.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
