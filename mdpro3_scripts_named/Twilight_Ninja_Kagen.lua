--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 黄昏之忍者-下弦  (ID: 6830480)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Warrior
-- Level 1
-- Pendulum Scales: L10 / R10
-- ATK 0 | DEF 2000
-- Setcode: 43
--
-- Effect Text:
-- ←10 【灵摆】 10→
-- ①：自己不是「忍者」怪兽不能灵摆召唤。这个效果不会被无效化。
-- ②：1回合1次，自己的「忍者」怪兽的攻击宣言时才能发动。那只怪兽的攻击力直到伤害步骤结束时上升1000。
-- 【怪兽效果】
-- ①：把这张卡解放，以自己场上1只「忍者」怪兽为对象才能发动。那只怪兽的攻击力直到回合结束时上升800。
--[[ __CARD_HEADER_END__ ]]

--黄昏の忍者－カゲン
function c6830480.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c6830480.splimit)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6830480,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c6830480.atkcon)
	e2:SetOperation(c6830480.atkop)
	c:RegisterEffect(e2)
	--gain atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6830480,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c6830480.cost)
	e3:SetTarget(c6830480.tg)
	e3:SetOperation(c6830480.op)
	c:RegisterEffect(e3)
end
function c6830480.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x2b) and bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c6830480.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(tp) and at:IsSetCard(0x2b)
end
function c6830480.atkop(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	if at:IsFaceup() and at:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		at:RegisterEffect(e1)
	end
end
function c6830480.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c6830480.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2b)
end
function c6830480.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c6830480.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c6830480.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c6830480.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c6830480.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(800)
		tc:RegisterEffect(e1)
	end
end
