--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 武器交换  (ID: 10035717)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 此效果只能在自己每回合的准备阶段支付700基本分发动1次。使自己场上1只战士族·机械族怪兽的攻击力与守备力互换直到对方的下一个结束阶段终了时为止。当这张卡被破坏时，此效果无效化。
--[[ __CARD_HEADER_END__ ]]

--ウェポンチェンジ
function c10035717.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10035717,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c10035717.adcon)
	e2:SetCost(c10035717.adcost)
	e2:SetTarget(c10035717.adtg)
	e2:SetOperation(c10035717.adop)
	c:RegisterEffect(e2)
end
function c10035717.adcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c10035717.adcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,700) end
	Duel.PayLPCost(tp,700)
end
function c10035717.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE+RACE_WARRIOR) and c:IsDefenseAbove(0)
end
function c10035717.adtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c10035717.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c10035717.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c10035717.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c10035717.adop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsRace(RACE_MACHINE+RACE_WARRIOR) then
		local atk=tc:GetAttack()
		local def=tc:GetDefense()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(def)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(atk)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e2)
	end
end
