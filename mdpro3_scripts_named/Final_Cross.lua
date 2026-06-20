--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 最终交错  (ID: 35756798)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：同调怪兽被送去自己墓地的自己回合，以自己场上1只同调怪兽为对象才能发动。这个回合，那只怪兽在同1次的战斗阶段中可以作2次攻击。以原本卡名包含「战士」、「同调士」、「星尘」之内任意种的同调怪兽为对象
-- 把这张卡发动的场合，可以再选自己墓地1只同调怪兽让作为对象的怪兽的攻击力上升那个攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--ファイナル・クロス
function c35756798.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,35756798+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c35756798.atkcon)
	e1:SetTarget(c35756798.atktg)
	e1:SetOperation(c35756798.atkop)
	c:RegisterEffect(e1)
	if not c35756798.global_check then
		c35756798.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_TO_GRAVE)
		ge1:SetCondition(c35756798.checkcon)
		ge1:SetOperation(c35756798.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c35756798.checkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsType,1,nil,TYPE_SYNCHRO)
end
function c35756798.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsType,nil,TYPE_SYNCHRO)
	local tc=g:GetFirst()
	while tc do
		if Duel.GetFlagEffect(tc:GetControler(),35756798)==0 then
			Duel.RegisterFlagEffect(tc:GetControler(),35756798,RESET_PHASE+PHASE_END,0,1)
		end
		if Duel.GetFlagEffect(0,35756798)>0 and Duel.GetFlagEffect(1,35756798)>0 then
			break
		end
		tc=g:GetNext()
	end
end
function c35756798.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFlagEffect(tp,35756798)
	return Duel.GetTurnPlayer()==tp and aux.bpcon(e,tp,eg,ep,ev,re,r,rp) and ct>0
end
function c35756798.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and not c:IsHasEffect(EFFECT_EXTRA_ATTACK)
end
function c35756798.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c35756798.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c35756798.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c35756798.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc:IsOriginalSetCard(0x66,0x1017,0xa3) then
		Duel.SetTargetParam(1)
	end
end
function c35756798.atkfilter(c)
	return c:IsType(TYPE_SYNCHRO) and c:GetAttack()>0
end
function c35756798.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local num=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		if num>0 and Duel.IsExistingMatchingCard(c35756798.atkfilter,tp,LOCATION_GRAVE,0,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(35756798,1)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
			local ag=Duel.SelectMatchingCard(tp,c35756798.atkfilter,tp,LOCATION_GRAVE,0,1,1,nil)
			Duel.HintSelection(ag)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetValue(ag:GetFirst():GetAttack())
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e2)
		end
	end
end
