--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 娱乐伙伴 泡泡斗牛犬  (ID: 34379489)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Beast
-- Level 6
-- Pendulum Scales: L5 / R5
-- ATK 2300 | DEF 1000
-- Setcode: 159
--
-- Effect Text:
-- ←5 【灵摆】 5→
-- ①：灵摆怪兽以外的从额外卡组特殊召唤的自己场上的表侧表示怪兽被战斗·效果破坏的场合，可以作为代替把这张卡破坏。
-- 【怪兽效果】
-- ①：这张卡从额外卡组的特殊召唤成功时才能发动。这个回合，从额外卡组特殊召唤的自己场上的灵摆怪兽不会被效果破坏。
--[[ __CARD_HEADER_END__ ]]

--EMバブルドッグ
function c34379489.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTarget(c34379489.reptg)
	e2:SetValue(c34379489.repval)
	e2:SetOperation(c34379489.repop)
	c:RegisterEffect(e2)
	--Indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c34379489.condition)
	e3:SetOperation(c34379489.operation)
	c:RegisterEffect(e3)
end
function c34379489.filter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and not c:IsType(TYPE_PENDULUM) and c:IsSummonLocation(LOCATION_EXTRA)
		and c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
end
function c34379489.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return eg:IsExists(c34379489.filter,1,nil,tp)
		and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED) end
	return Duel.SelectEffectYesNo(tp,c,96)
end
function c34379489.repval(e,c)
	return c34379489.filter(c,e:GetHandlerPlayer())
end
function c34379489.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end
function c34379489.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_EXTRA)
end
function c34379489.operation(e,tp,eg,ep,ev,re,r,rp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c34379489.indtg)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetValue(1)
	Duel.RegisterEffect(e2,tp)
end
function c34379489.indtg(e,c)
	return c:IsType(TYPE_PENDULUM) and c:IsSummonLocation(LOCATION_EXTRA)
end
