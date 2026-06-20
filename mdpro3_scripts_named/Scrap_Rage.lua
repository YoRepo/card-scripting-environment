--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 废铁反击  (ID: 59699355)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 36
--
-- Effect Text:
-- 场上守备表示存在的名字带有「废铁」的怪兽被攻击的场合，那次伤害计算时才能发动。被攻击的名字带有「废铁」的怪兽的守备力上升2000，战斗阶段结束时破坏。
--[[ __CARD_HEADER_END__ ]]

--スクラップ・カウンター
function c59699355.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c59699355.condition)
	e1:SetOperation(c59699355.activate)
	c:RegisterEffect(e1)
end
function c59699355.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsDefensePos() and d:IsSetCard(0x24)
end
function c59699355.activate(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetValue(2000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		d:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
		e2:SetCountLimit(1)
		e2:SetOperation(c59699355.desop)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		d:RegisterEffect(e2)
	end
end
function c59699355.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
