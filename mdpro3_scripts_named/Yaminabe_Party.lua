--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 暗味锅派对  (ID: 24181936)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己战斗阶段开始时，以自己场上1只表侧表示怪兽为对象才能发动。这个回合，那只自己怪兽的攻击对象由对方选择，那只自己怪兽的攻击力只在和对方怪兽进行战斗的伤害计算时上升自身的原本攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--闇味鍋パーティー
function c24181936.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--attack select
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(24181936,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,24181936)
	e2:SetCondition(c24181936.atkcon1)
	e2:SetTarget(c24181936.atktg1)
	e2:SetOperation(c24181936.atkop1)
	c:RegisterEffect(e2)
end
function c24181936.atkcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c24181936.atktg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c24181936.atkop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if tc:GetFlagEffect(24181936)==0 then
			tc:RegisterFlagEffect(24181936,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_PATRICIAN_OF_DARKNESS)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetTargetRange(1,0)
			e1:SetCondition(c24181936.effcon)
			e1:SetLabelObject(tc)
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetTargetRange(LOCATION_MZONE,0)
			e2:SetCondition(c24181936.atkcon2)
			e2:SetTarget(c24181936.atktg)
			e2:SetValue(c24181936.atkval)
			e2:SetLabelObject(tc)
			e2:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e2,tp)
		end
	end
end
function c24181936.effcon(e)
	local tc=e:GetLabelObject()
	return tc:GetFlagEffect(24181936)~=0 and Duel.GetAttacker()==tc
end
function c24181936.atkcon2(e)
	local tc=e:GetLabelObject()
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL
		and tc:GetFlagEffect(24181936)~=0 and Duel.GetAttacker()==tc and Duel.GetAttackTarget()~=nil
end
function c24181936.atktg(e,c)
	return c==Duel.GetAttacker()
end
function c24181936.atkval(e,c)
	return c:GetBaseAttack()
end
