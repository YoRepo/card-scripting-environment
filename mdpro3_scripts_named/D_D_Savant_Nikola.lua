--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: DD 魔导贤者 尼古拉  (ID: 46035545)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 6
-- Pendulum Scales: L8 / R8
-- ATK 2000 | DEF 2000
-- Setcode: 7209135
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- ①：自己不是「DD」怪兽不能灵摆召唤。这个效果不会被无效化。
-- ②：1回合1次，从手卡丢弃1只「DDD」怪兽，以自己场上1只6星以下的「DD」怪兽为对象才能发动。那只怪兽的攻击力·守备力直到回合结束时上升2000。
-- 【怪兽效果】
-- 「DD 魔导贤者 尼古拉」的怪兽效果1回合只能使用1次。
-- ①：这张卡在灵摆区域被破坏的场合，以自己场上1只「DDD」怪兽为对象才能发动。那只怪兽回到持有者手卡，从自己的额外卡组选最多2只表侧表示的「DD」灵摆怪兽在自己的灵摆区域放置。那些卡的灵摆效果在这个回
-- 合不能发动。
--[[ __CARD_HEADER_END__ ]]

--DD魔導賢者ニコラ
function c46035545.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c46035545.splimit)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(46035545,0))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCost(c46035545.atkcost)
	e2:SetTarget(c46035545.atktg)
	e2:SetOperation(c46035545.atkop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,46035545)
	e3:SetCondition(c46035545.thcon)
	e3:SetTarget(c46035545.thtg)
	e3:SetOperation(c46035545.thop)
	c:RegisterEffect(e3)
end
function c46035545.splimit(e,c,sump,sumtype,sumpos,targetp)
	return not c:IsSetCard(0xaf) and bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c46035545.atkcfilter(c)
	return c:IsSetCard(0x10af) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c46035545.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c46035545.atkcfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c46035545.atkcfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c46035545.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xaf) and c:IsLevelBelow(6)
end
function c46035545.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c46035545.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c46035545.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c46035545.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c46035545.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(2000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
	end
end
function c46035545.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_PZONE)
end
function c46035545.thfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x10af) and c:IsAbleToHand()
end
function c46035545.pfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xaf) and c:IsType(TYPE_PENDULUM) and not c:IsForbidden()
end
function c46035545.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c46035545.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c46035545.thfilter,tp,LOCATION_MZONE,0,1,nil)
		and (Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1))
		and Duel.IsExistingMatchingCard(c46035545.pfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c46035545.thfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c46035545.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0
		and tc:IsLocation(LOCATION_HAND) then
		local ct=0
		if Duel.CheckLocation(tp,LOCATION_PZONE,0) then ct=ct+1 end
		if Duel.CheckLocation(tp,LOCATION_PZONE,1) then ct=ct+1 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local g=Duel.SelectMatchingCard(tp,c46035545.pfilter,tp,LOCATION_EXTRA,0,1,ct,nil)
		local pc=g:GetFirst()
		while pc do
			Duel.MoveToField(pc,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_TRIGGER)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			pc:RegisterEffect(e1,true)
			pc=g:GetNext()
		end
	end
end
