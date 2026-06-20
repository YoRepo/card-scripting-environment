--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: DD 刻耳柏洛斯  (ID: 39153655)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- Pendulum Scales: L6 / R6
-- ATK 1800 | DEF 600
-- Setcode: 175
--
-- Effect Text:
-- ←6 【灵摆】 6→
-- ①：1回合1次，以自己场上1只「DD」怪兽为对象才能发动。那只怪兽的等级变成4星，攻击力·守备力上升400。
-- 【怪兽效果】
-- ①：这张卡从手卡的灵摆召唤成功时，「DD 刻耳柏洛斯」以外的「DD」怪兽在自己场上存在的场合以自己墓地1张永续魔法卡为对象才能发动。那张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--DDケルベロス
function c39153655.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(39153655,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c39153655.atktg)
	e2:SetOperation(c39153655.atkop)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c39153655.thcon)
	e3:SetTarget(c39153655.thtg)
	e3:SetOperation(c39153655.thop)
	c:RegisterEffect(e3)
end
function c39153655.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xaf) and not c:IsLevel(4) and c:IsLevelAbove(1)
end
function c39153655.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c39153655.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c39153655.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c39153655.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c39153655.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsLevel(4) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(4)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(400)
		tc:RegisterEffect(e2)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e3)
	end
end
function c39153655.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xaf) and not c:IsCode(39153655)
end
function c39153655.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_PENDULUM) and c:IsPreviousLocation(LOCATION_HAND)
		and Duel.IsExistingMatchingCard(c39153655.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c39153655.thfilter(c)
	return c:GetType()==TYPE_SPELL+TYPE_CONTINUOUS and c:IsAbleToHand()
end
function c39153655.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c39153655.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c39153655.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c39153655.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c39153655.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
