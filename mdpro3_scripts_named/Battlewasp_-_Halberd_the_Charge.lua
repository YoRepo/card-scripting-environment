--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Battlewasp - Halberd the Charge  (ID: 53950487)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Insect
-- Level: 6
-- ATK 2500 | DEF 800
-- Setcode: 0x12f
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Insect Tuner + 1+ non-Tuner monsters
-- Once per battle, during damage calculation, if this card attacks an opponent's monster with equal or
-- higher ATK (Quick Effect): You can halve the ATK of that opponent's monster, during that damage
-- calculation only.
-- When this card inflicts battle damage to your opponent: You can inflict 200 damage to your opponent
-- for each "Battlewasp" monster you control.
-- You can only use this effect of "Battlewasp - Halberd the Charge" once per turn.
--[[ __CARD_HEADER_END__ ]]

--B・F－突撃のヴォウジェ
function c53950487.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_INSECT),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--atk change
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c53950487.atkcon)
	e1:SetCost(c53950487.atkcost)
	e1:SetOperation(c53950487.atkop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCountLimit(1,53950487)
	e2:SetCondition(c53950487.damcon)
	e2:SetTarget(c53950487.damtg)
	e2:SetOperation(c53950487.damop)
	c:RegisterEffect(e2)
end
function c53950487.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	return c==Duel.GetAttacker() and tc and tc:IsFaceup() and tc:IsControler(1-tp) and tc:IsAttackAbove(c:GetAttack())
end
function c53950487.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(53950487)==0 end
	c:RegisterFlagEffect(53950487,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c53950487.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if c:IsRelateToBattle() and c:IsFaceup() and tc:IsRelateToBattle() and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(math.ceil(tc:GetAttack()/2))
		tc:RegisterEffect(e1)
	end
end
function c53950487.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c53950487.damfilter(c)
	return c:IsSetCard(0x12f) and c:IsFaceup()
end
function c53950487.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c53950487.damfilter,tp,LOCATION_MZONE,0,1,nil) end
	local val=Duel.GetMatchingGroupCount(c53950487.damfilter,tp,LOCATION_MZONE,0,nil)*200
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(val)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,val)
end
function c53950487.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local val=Duel.GetMatchingGroupCount(c53950487.damfilter,tp,LOCATION_MZONE,0,nil)*200
	Duel.Damage(p,val,REASON_EFFECT)
end
