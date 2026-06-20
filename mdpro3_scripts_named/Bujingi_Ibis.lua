--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 武神器-尾羽张  (ID: 16157341)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Winged Beast
-- Level 4
-- ATK 1600 | DEF 300
-- Setcode: 136
--
-- Effect Text:
-- 自己的主要阶段1，把这张卡从手卡送去墓地，选择自己场上1只名字带有「武神」的怪兽才能发动。这个回合，选择的怪兽向守备表示怪兽攻击时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--武神器－オハバリ
function c16157341.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16157341,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c16157341.condition)
	e1:SetCost(c16157341.cost)
	e1:SetTarget(c16157341.target)
	e1:SetOperation(c16157341.operation)
	c:RegisterEffect(e1)
end
function c16157341.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c16157341.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c16157341.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x88) and not c:IsHasEffect(EFFECT_PIERCE)
end
function c16157341.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c16157341.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c16157341.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c16157341.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c16157341.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_PIERCE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
