--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 米之七音服·埃莉蒂娅  (ID: 28115467)
-- Type: Monster / Effect / Pendulum
-- Attribute: WATER
-- Race: Fairy
-- Level 3
-- Pendulum Scales: L6 / R6
-- ATK 1100 | DEF 400
-- Setcode: 354
--
-- Effect Text:
-- ←6 【灵摆】 6→
-- ①：自己的「七音服」灵摆怪兽的灵摆召唤不会被无效化。
-- 【怪兽效果】
-- 这个卡名的①的怪兽效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合，以对方场上1张魔法·陷阱卡为对象才能发动。那张卡回到持有者手卡。
-- ②：只要自己的灵摆区域有偶数的灵摆刻度存在，自己的「七音服」灵摆怪兽的战斗发生的对自己的战斗伤害变成0。
--[[ __CARD_HEADER_END__ ]]

--ミドレミコード・エリーティア
function c28115467.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--cannot disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e1:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTarget(c28115467.distg)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(28115467,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,28115467)
	e2:SetTarget(c28115467.thtg)
	e2:SetOperation(c28115467.thop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--avoid battle damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetCondition(c28115467.avcon)
	e4:SetTarget(c28115467.avfilter)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c28115467.distg(e,c)
	return c:IsControler(e:GetHandlerPlayer()) and c:IsSetCard(0x162) and c:IsType(TYPE_PENDULUM) and c:IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c28115467.thfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c28115467.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c28115467.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c28115467.thfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c28115467.thfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c28115467.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c28115467.pfilter(c)
	return c:GetCurrentScale()%2==0
end
function c28115467.avcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c28115467.pfilter,tp,LOCATION_PZONE,0,1,nil)
end
function c28115467.avfilter(e,c)
	return c:IsSetCard(0x162) and c:IsType(TYPE_PENDULUM)
end
