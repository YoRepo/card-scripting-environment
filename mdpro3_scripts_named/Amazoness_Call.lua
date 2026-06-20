--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 亚马逊的叫声  (ID: 57312333)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 4
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组选「亚马逊的叫声」以外的1张「亚马逊」卡加入手卡或送去墓地。
-- ②：自己主要阶段把墓地的这张卡除外，以自己场上1只「亚马逊」怪兽为对象才能发动。这个回合，那只怪兽以外的自己怪兽不能攻击，作为对象的怪兽可以向对方怪兽全部各作1次攻击。
--[[ __CARD_HEADER_END__ ]]

--アマゾネスの叫声
function c57312333.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,57312333+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c57312333.target)
	e1:SetOperation(c57312333.activate)
	c:RegisterEffect(e1)
	--multi attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(57312333,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(c57312333.atkcost)
	e2:SetTarget(c57312333.atktg)
	e2:SetOperation(c57312333.atkop)
	c:RegisterEffect(e2)
end
function c57312333.filter(c)
	return c:IsSetCard(0x4) and not c:IsCode(57312333) and (c:IsAbleToHand() or c:IsAbleToGrave())
end
function c57312333.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c57312333.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c57312333.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=Duel.SelectMatchingCard(tp,c57312333.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and tc:IsAbleToHand() and (not tc:IsAbleToGrave() or Duel.SelectOption(tp,1190,1191)==0) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	else
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end
function c57312333.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
function c57312333.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4)
end
function c57312333.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c57312333.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c57312333.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c57312333.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c57312333.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ATTACK_ALL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c57312333.ftarget)
	e2:SetLabel(tc:GetFieldID())
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c57312333.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
