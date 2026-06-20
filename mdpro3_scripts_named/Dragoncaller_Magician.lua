--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 降龙之魔术师  (ID: 45667991)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Spellcaster
-- Level 7
-- Pendulum Scales: L2 / R2
-- ATK 2400 | DEF 1000
-- Setcode: 152
--
-- Effect Text:
-- ←2 【灵摆】 2→
-- ①：1回合1次，以场上1只表侧表示怪兽为对象才能发动。那只怪兽的种族直到对方回合结束时变成龙族。
-- 【怪兽效果】
-- ①：1回合1次，自己主要阶段才能发动。这张卡的种族直到回合结束时变成龙族。
-- ②：场上的这张卡为素材作融合·同调·超量召唤的怪兽得到以下效果。
-- ●这张卡和龙族怪兽进行战斗的伤害步骤内，这张卡的攻击力变成原本攻击力的2倍。
--[[ __CARD_HEADER_END__ ]]

--降竜の魔術師
function c45667991.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--change race
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45667991,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTarget(c45667991.rctg1)
	e1:SetOperation(c45667991.rcop1)
	c:RegisterEffect(e1)
	--change race
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(45667991,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c45667991.rctg2)
	e2:SetOperation(c45667991.rcop2)
	c:RegisterEffect(e2)
	--effect gain
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetProperty(EFFECT_FLAG_EVENT_PLAYER)
	e3:SetCondition(c45667991.efcon)
	e3:SetOperation(c45667991.efop)
	c:RegisterEffect(e3)
end
function c45667991.rcfilter(c)
	return c:IsFaceup() and not c:IsRace(RACE_DRAGON)
end
function c45667991.rctg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c45667991.rcfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c45667991.rcfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c45667991.rcfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c45667991.rcop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetValue(RACE_DRAGON)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		tc:RegisterEffect(e1)
	end
end
function c45667991.rctg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsRace(RACE_DRAGON) end
end
function c45667991.rcop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetValue(RACE_DRAGON)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c45667991.efcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_FUSION+REASON_SYNCHRO+REASON_XYZ)~=0
		and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c45667991.efop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(rc)
	e1:SetDescription(aux.Stringid(45667991,2))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c45667991.atkcon)
	e1:SetValue(c45667991.atkval)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	rc:RegisterEffect(e1,true)
	if not rc:IsType(TYPE_EFFECT) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_ADD_TYPE)
		e2:SetValue(TYPE_EFFECT)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		rc:RegisterEffect(e2,true)
	end
end
function c45667991.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	local bc=e:GetHandler():GetBattleTarget()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and bc and bc:IsRace(RACE_DRAGON)
end
function c45667991.atkval(e,c)
	return e:GetHandler():GetBaseAttack()*2
end
