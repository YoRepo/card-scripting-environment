--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 机皇厂  (ID: 77864539)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 19
--
-- Effect Text:
-- 场上表侧表示存在的名字带有「机皇」的怪兽被选择作为攻击对象时才能发动。选择自己墓地存在的1只名字带有「机皇兵」的怪兽加入手卡。那之后，成为攻击对象的怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--機皇廠
function c77864539.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c77864539.condition)
	e1:SetTarget(c77864539.target)
	e1:SetOperation(c77864539.activate)
	c:RegisterEffect(e1)
end
function c77864539.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d:IsFaceup() and d:IsSetCard(0x13)
end
function c77864539.filter(c)
	return c:IsSetCard(0x6013) and c:IsAbleToHand()
end
function c77864539.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c77864539.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c77864539.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c77864539.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	local d=Duel.GetAttackTarget()
	d:RegisterFlagEffect(77864539,RESET_EVENT+0x3fe0000,0,1)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,d,1,0,0)
end
function c77864539.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		local d=Duel.GetAttackTarget()
		if d:GetFlagEffect(77864539)~=0 then
			Duel.Destroy(d,REASON_EFFECT)
		end
	end
end
