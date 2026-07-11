--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Friller Rabca  (ID: 93830681)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level: 3
-- ATK 700 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a Fish, Sea Serpent, or Aqua-Type monster you control is targeted for an attack: You can banish
-- this card from your Graveyard, then target the attacking monster; negate the attack, and if you do,
-- that target loses 500 ATK until the end of the next turn.
-- You can only use this effect of "Friller Rabca" once per turn.
--[[ __CARD_HEADER_END__ ]]

--キラー・ラブカ
function c93830681.initial_effect(c)
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(93830681,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,93830681)
	e1:SetCondition(c93830681.condition)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c93830681.target)
	e1:SetOperation(c93830681.operation)
	c:RegisterEffect(e1)
end
function c93830681.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at and at:IsControler(tp) and at:IsFaceup() and at:IsRace(RACE_FISH+RACE_SEASERPENT+RACE_AQUA)
end
function c93830681.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c93830681.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.NegateAttack()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e1)
	end
end
