--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Exarion Universe  (ID: 63749102)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast-Warrior
-- Level: 4
-- ATK 1800 | DEF 1900
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your Battle Step, if this card attacks a Defense Position monster: You can make this card
-- lose exactly 400 ATK, and if it does, it will inflict piercing battle damage.
-- These effects last until the end of this turn.
--[[ __CARD_HEADER_END__ ]]

--イグザリオン・ユニバース
function c63749102.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63749102,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetHintTiming(0,TIMING_BATTLE_PHASE)
	e1:SetCondition(c63749102.atkcon)
	e1:SetOperation(c63749102.atkop)
	c:RegisterEffect(e1)
end
function c63749102.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()==0 and e:GetHandler()==Duel.GetAttacker() and Duel.GetAttackTarget() and Duel.GetAttackTarget():IsDefensePos()
end
function c63749102.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(-400)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_PIERCE)
		c:RegisterEffect(e2)
	end
end
