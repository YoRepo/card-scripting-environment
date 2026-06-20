--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 绝对权力强要  (ID: 51779204)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：以自己场上1只「红莲魔龙」为对象才能发动。这个回合，那只自己怪兽和对方怪兽进行战斗的场合，直到伤害步骤结束时以下效果适用。
-- ●作为对象的怪兽的攻击力上升1000。
-- ●对方不能把魔法·陷阱·怪兽的效果发动。
-- ●作为对象的怪兽向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
-- ●那次战斗发生的对对方的战斗伤害变成2倍。
--[[ __CARD_HEADER_END__ ]]

--アブソリュート・パワーフォース
function c51779204.initial_effect(c)
	aux.AddCodeList(c,70902743)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(aux.bpcon)
	e1:SetTarget(c51779204.target)
	e1:SetOperation(c51779204.activate)
	c:RegisterEffect(e1)
end
function c51779204.filter(c)
	return c:IsFaceup() and c:IsCode(70902743)
end
function c51779204.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c51779204.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c51779204.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c51779204.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c51779204.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetCondition(c51779204.atkcon)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		if tc:GetFlagEffect(51779204)==0 then
			tc:RegisterFlagEffect(51779204,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e2:SetCode(EFFECT_CANNOT_ACTIVATE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetTargetRange(0,1)
			e2:SetCondition(c51779204.actcon)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2,true)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_PIERCE)
			e3:SetCondition(c51779204.effcon)
			e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e3)
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
			e4:SetCondition(c51779204.damcon)
			e4:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
			e4:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e4,true)
		end
	end
end
function c51779204.atkcon(e)
	if bit.band(Duel.GetCurrentPhase(),PHASE_DAMAGE+PHASE_DAMAGE_CAL)==0 then return false end
	local c=e:GetHandler()
	return (Duel.GetAttacker()==c or Duel.GetAttackTarget()==c) and c:GetBattleTarget()~=nil
		and e:GetOwnerPlayer()==e:GetHandlerPlayer()
end
function c51779204.actcon(e)
	local c=e:GetHandler()
	return (Duel.GetAttacker()==c or Duel.GetAttackTarget()==c) and c:GetBattleTarget()~=nil
		and e:GetOwnerPlayer()==e:GetHandlerPlayer()
end
function c51779204.effcon(e)
	return e:GetOwnerPlayer()==e:GetHandlerPlayer()
end
function c51779204.damcon(e)
	return e:GetHandler():GetBattleTarget()~=nil
end
