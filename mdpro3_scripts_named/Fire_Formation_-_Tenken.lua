--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 炎舞-「天权」  (ID: 70329348)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 124
--
-- Effect Text:
-- 这张卡在主要阶段1才能发动。这张卡的发动时，选择自己场上1只兽战士族怪兽。只在这张卡发动的主要阶段1内，选择的怪兽的效果无效，不受这张卡以外的卡的效果影响。此外，只要这张卡在场上存在，自己场上的兽战士
-- 族怪兽的攻击力上升300。
--[[ __CARD_HEADER_END__ ]]

--炎舞－「天権」
function c70329348.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_MAIN_END)
	e1:SetCondition(c70329348.condition)
	e1:SetTarget(c70329348.target)
	e1:SetOperation(c70329348.activate)
	c:RegisterEffect(e1)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_BEASTWARRIOR))
	e3:SetValue(300)
	c:RegisterEffect(e3)
end
function c70329348.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c70329348.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_BEASTWARRIOR)
end
function c70329348.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c70329348.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c70329348.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c70329348.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c70329348.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_MAIN1)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_MAIN1)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EFFECT_IMMUNE_EFFECT)
		e3:SetValue(c70329348.efilter)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_MAIN1)
		tc:RegisterEffect(e3)
	end
end
function c70329348.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
