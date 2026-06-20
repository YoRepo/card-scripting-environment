--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 异界空间-A地带  (ID: 60946968)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方怪兽和自己场上存在的名字带有「外星」的怪兽战斗的场合，对方怪兽的攻击力·守备力只在伤害计算时下降300。
--[[ __CARD_HEADER_END__ ]]

--異界空間－Aゾーン
function c60946968.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c60946968.adcon)
	e2:SetTarget(c60946968.adtg)
	e2:SetValue(-300)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function c60946968.adcon(e)
	if Duel.GetCurrentPhase()~=PHASE_DAMAGE_CAL then return false end
	local d=Duel.GetAttackTarget()
	if not d then return false end
	local tp=e:GetHandlerPlayer()
	if d:IsControler(1-tp) then d=Duel.GetAttacker() end
	return d:IsSetCard(0xc)
end
function c60946968.adtg(e,c)
	return c==Duel.GetAttacker() or c==Duel.GetAttackTarget()
end
