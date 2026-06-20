--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 电气城堡  (ID: 58924378)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 14
--
-- Effect Text:
-- 只要这张卡在场上存在，向名字带有「电气」的怪兽攻击的怪兽的攻击力在那次伤害计算后下降1000。
--[[ __CARD_HEADER_END__ ]]

--エレキャッスル
function c58924378.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--flag effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLED)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCondition(c58924378.atkcon)
	e2:SetOperation(c58924378.atkop)
	c:RegisterEffect(e2)
	--atk down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c58924378.target)
	e3:SetValue(-1000)
	c:RegisterEffect(e3)
end
function c58924378.target(e,c)
	local fid=e:GetHandler():GetFieldID()
	return c:GetFlagEffect(58924378)~=0 and c:GetFlagEffectLabel(58924378)==fid
end
function c58924378.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and d:IsSetCard(0xe) and not c58924378.target(e,a)
end
function c58924378.atkop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local fid=e:GetHandler():GetFieldID()
	a:RegisterFlagEffect(58924378,RESETS_STANDARD,0,1,fid)
end
