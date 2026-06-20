--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 魔界剧团-闪烁小明星  (ID: 7279373)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- Pendulum Scales: L9 / R9
-- ATK 1000 | DEF 1000
-- Setcode: 4332
--
-- Effect Text:
-- ←9 【灵摆】 9→
-- ①：自己不是「魔界剧团」怪兽不能灵摆召唤。这个效果不会被无效化。
-- ②：1回合1次，以自己场上1只「魔界剧团」怪兽为对象才能发动。这个回合，那只怪兽在同1次的战斗阶段中最多3次可以向怪兽攻击，作为对象的怪兽以外的自己怪兽不能攻击。
-- 【怪兽效果】
-- ①：这张卡在自己回合不会被战斗破坏，同1次的战斗阶段中最多3次可以向怪兽攻击。
--[[ __CARD_HEADER_END__ ]]

--魔界劇団－ティンクル・リトルスター
function c7279373.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c7279373.splimit)
	c:RegisterEffect(e1)
	--attack thrice
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(7279373,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c7279373.atkcon)
	e2:SetTarget(c7279373.atktg)
	e2:SetOperation(c7279373.atkop)
	c:RegisterEffect(e2)
	--attack thrice
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(2)
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetCondition(c7279373.indcon)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c7279373.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0x10ec) and bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c7279373.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c7279373.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x10ec)
end
function c7279373.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c7279373.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c7279373.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c7279373.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c7279373.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c7279373.ftarget)
	e2:SetLabel(tc:GetFieldID())
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c7279373.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c7279373.indcon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end
