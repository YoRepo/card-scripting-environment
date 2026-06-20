--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 百兽之圣像骑士  (ID: 28031913)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 3
-- ATK 1200 | DEF 1600
-- Setcode: 278
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：这张卡可以从手卡往作为连接怪兽所连接区的自己场上守备表示特殊召唤。
-- ②：以自己场上1只「圣像骑士」连接怪兽为对象才能发动。这个回合，那只怪兽向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--百獣のパラディオン
function c28031913.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,0)
	e1:SetCountLimit(1,28031913+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c28031913.spcon)
	e1:SetValue(c28031913.spval)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(28031913,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,28031914)
	e2:SetCondition(c28031913.condition)
	e2:SetTarget(c28031913.target)
	e2:SetOperation(c28031913.operation)
	c:RegisterEffect(e2)
end
function c28031913.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local zone=Duel.GetLinkedZone(tp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
end
function c28031913.spval(e,c)
	return 0,Duel.GetLinkedZone(c:GetControler())
end
function c28031913.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c28031913.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x116) and c:IsType(TYPE_LINK) and not c:IsHasEffect(EFFECT_PIERCE)
end
function c28031913.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(c28031913.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c28031913.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c28031913.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_PIERCE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
