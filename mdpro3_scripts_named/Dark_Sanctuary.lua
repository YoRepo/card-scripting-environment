--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Dark Sanctuary  (ID: 16625614)
-- Type: Spell / Field
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a "Spirit Message" card would be placed on your field with "Destiny Board", you can Special
-- Summon it as a Normal Monster (Fiend/DARK/Level 1/ATK 0/DEF 0) instead, and if you do, it is
-- unaffected by card effects, except "Destiny Board", and cannot be targeted for attacks, but does not
-- prevent your opponent from attacking you directly.
-- When an opponent's monster declares an attack: Toss a coin and if the result is heads, negate the
-- attack, and if you do, inflict damage to your opponent equal to half the current ATK of that
-- opponent's monster.
--[[ __CARD_HEADER_END__ ]]

--ダーク・サンクチュアリ
function c16625614.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--update effect check
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(16625614)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	c:RegisterEffect(e2)
	--negate attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCategory(CATEGORY_COIN)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCondition(c16625614.condition)
	e4:SetTarget(c16625614.target)
	e4:SetOperation(c16625614.operation)
	c:RegisterEffect(e4)
end
function c16625614.efilter(e,te)
	local tc=te:GetHandler()
	return not tc:IsCode(94212438)
end
function c16625614.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c16625614.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c16625614.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local coin=Duel.TossCoin(tp,1)
	if coin==1 then
		if Duel.NegateAttack() then
			Duel.Damage(1-tp,math.floor(tc:GetAttack()/2),REASON_EFFECT)
		end
	end
end
