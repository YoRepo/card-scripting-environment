--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Canyon  (ID: 28120197)
-- Type: Spell / Field
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a Rock-Type monster in Defense Position is attacked, double any Battle Damage to the controller
-- of the attacking monster.
--[[ __CARD_HEADER_END__ ]]

--断層地帯
function c28120197.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage amp
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetCondition(c28120197.dcon1)
	e2:SetValue(DOUBLE_DAMAGE)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetTargetRange(0,1)
	e3:SetCondition(c28120197.dcon2)
	c:RegisterEffect(e3)
end
function c28120197.dcon1(e)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return a:GetControler()==e:GetHandlerPlayer()
		and d and d:IsDefensePos() and d:IsRace(RACE_ROCK)
end
function c28120197.dcon2(e)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return a:GetControler()==1-e:GetHandlerPlayer()
		and d and d:IsDefensePos() and d:IsRace(RACE_ROCK)
end
