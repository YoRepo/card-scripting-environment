--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 相生之魔术师  (ID: 17086528)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- Pendulum Scales: L8 / R8
-- ATK 500 | DEF 1500
-- Setcode: 152
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- ①：1回合1次，以自己场上1只超量怪兽和1只5星以上的怪兽为对象才能发动。那只超量怪兽的阶级直到回合结束时变成和那只5星以上的怪兽的等级数值相同。
-- ②：自己场上的卡比对方场上多的场合，这张卡的灵摆刻度变成4。
-- 【怪兽效果】
-- ①：这张卡的战斗发生的对对方的战斗伤害变成0。
-- ②：1回合1次，以这张卡以外的自己场上1只怪兽为对象才能发动。这张卡的攻击力直到回合结束时变成和那只怪兽相同。
--[[ __CARD_HEADER_END__ ]]

--相生の魔術師
function c17086528.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--rank
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c17086528.rktg)
	e2:SetOperation(c17086528.rkop)
	c:RegisterEffect(e2)
	--scale
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CHANGE_LSCALE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCondition(c17086528.slcon)
	e3:SetValue(4)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CHANGE_RSCALE)
	c:RegisterEffect(e4)
	--damage 0
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	c:RegisterEffect(e5)
	--atk
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_ATKCHANGE)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetCountLimit(1)
	e6:SetTarget(c17086528.atktg)
	e6:SetOperation(c17086528.atkop)
	c:RegisterEffect(e6)
end
function c17086528.rkfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
		and Duel.IsExistingTarget(c17086528.lvfilter,tp,LOCATION_MZONE,0,1,c,c:GetRank())
end
function c17086528.lvfilter(c,rk)
	return c:IsFaceup() and c:IsLevelAbove(5) and not c:IsLevel(rk)
end
function c17086528.rktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c17086528.rkfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c17086528.rkfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	e:SetLabelObject(g:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c17086528.lvfilter,tp,LOCATION_MZONE,0,1,1,g:GetFirst(),g:GetFirst():GetRank())
end
function c17086528.rkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local lc=tg:GetFirst()
	if lc==tc then lc=tg:GetNext() end
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and lc:IsRelateToEffect(e) and lc:IsFaceup() and lc:IsLevelAbove(5) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RANK)
		e1:SetValue(lc:GetLevel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c17086528.slcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)>Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)
end
function c17086528.atkfilter(c,atk)
	return c:IsFaceup() and not c:IsAttack(atk)
end
function c17086528.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local atk=c:GetAttack()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc~=c and c17086528.atkfilter(chkc,atk) end
	if chk==0 then return Duel.IsExistingTarget(c17086528.atkfilter,tp,LOCATION_MZONE,0,1,c,atk) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c17086528.atkfilter,tp,LOCATION_MZONE,0,1,1,c,atk)
end
function c17086528.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local atk=tc:GetAttack()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
