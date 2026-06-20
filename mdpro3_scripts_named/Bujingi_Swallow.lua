--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 武神器-八握  (ID: 86868952)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Winged Beast
-- Level 4
-- ATK 1700 | DEF 800
-- Setcode: 136
--
-- Effect Text:
-- 自己的主要阶段1，把这张卡从手卡送去墓地，选择自己场上1只名字带有「武神」的怪兽才能发动。这个回合，选择的怪兽在同1次的战斗阶段中可以作2次攻击。这个效果发动的回合，选择的怪兽以外的怪兽不能攻击。
--[[ __CARD_HEADER_END__ ]]

--武神器－ヤツカ
function c86868952.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86868952,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c86868952.condition)
	e1:SetCost(c86868952.cost)
	e1:SetTarget(c86868952.target)
	e1:SetOperation(c86868952.operation)
	c:RegisterEffect(e1)
end
function c86868952.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c86868952.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c86868952.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x88) and not c:IsHasEffect(EFFECT_EXTRA_ATTACK)
end
function c86868952.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c86868952.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c86868952.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c86868952.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_OATH)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c86868952.ftarget)
	e1:SetLabel(g:GetFirst():GetFieldID())
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c86868952.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c86868952.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
end
