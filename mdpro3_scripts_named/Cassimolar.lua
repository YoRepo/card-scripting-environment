--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 卡西莫拉尔  (ID: 12527118)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 1000 | DEF 1200
--
-- Effect Text:
-- ①：这张卡召唤成功时，以对方场上1只表侧表示怪兽为对象才能发动。那只怪兽的攻击力上升那个原本攻击力数值。这个效果适用的怪兽在下个回合的结束阶段破坏，对方受到那个原本攻击力一半数值的伤害。
-- ②：对方战斗阶段开始时，把通常召唤的这张卡解放才能发动。这个回合，对方怪兽不能直接攻击。
--[[ __CARD_HEADER_END__ ]]

--カシモラル
function c12527118.initial_effect(c)
	--atk change
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c12527118.atktg)
	e1:SetOperation(c12527118.atkop)
	c:RegisterEffect(e1)
	--atk limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c12527118.limcon)
	e2:SetCost(c12527118.limcost)
	e2:SetOperation(c12527118.limop)
	c:RegisterEffect(e2)
end
function c12527118.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c12527118.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(tc:GetBaseAttack())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local fid=c:GetFieldID()
		tc:RegisterFlagEffect(12527118,RESET_EVENT+RESETS_STANDARD,0,1,fid)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetReset(RESET_PHASE+PHASE_END,2)
		e2:SetCountLimit(1)
		e2:SetLabel(fid,Duel.GetTurnCount())
		e2:SetLabelObject(tc)
		e2:SetCondition(c12527118.descon)
		e2:SetOperation(c12527118.desop)
		Duel.RegisterEffect(e2,tp)
	end
end
function c12527118.descon(e,tp,eg,ep,ev,re,r,rp)
	local fid,ct=e:GetLabel()
	local tc=e:GetLabelObject()
	return Duel.GetTurnCount()~=ct and tc:GetFlagEffectLabel(12527118)==fid
end
function c12527118.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,math.floor(tc:GetBaseAttack()/2),REASON_EFFECT)
	end
end
function c12527118.limcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and e:GetHandler():IsSummonType(SUMMON_TYPE_NORMAL)
end
function c12527118.limcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c12527118.limop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
