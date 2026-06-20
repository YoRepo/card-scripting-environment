--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 眩月龙 塞勒格莱尔  (ID: 29303524)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 6
-- ATK 2400 | DEF 1000
--
-- Effect Text:
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡可以不用解放作通常召唤。
-- ②：这张卡的①的方法通常召唤的这张卡的原本攻击力变成1500。
-- ③：自己·对方的主要阶段，以持有这张卡的攻击力以下的攻击力的对方场上1只怪兽为对象才能发动。场上的这张卡回到手卡，作为对象的怪兽的控制权直到结束阶段得到。
--[[ __CARD_HEADER_END__ ]]

--眩月龍セレグレア
function c29303524.initial_effect(c)
	--summon & set with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29303524,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c29303524.ntcon)
	e1:SetOperation(c29303524.ntop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e2)
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(29303524,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_CONTROL)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,29303524)
	e3:SetHintTiming(0,TIMING_MAIN_END)
	e3:SetCondition(c29303524.ctcon)
	e3:SetTarget(c29303524.cttg)
	e3:SetOperation(c29303524.ctop)
	c:RegisterEffect(e3)
end
function c29303524.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c29303524.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetReset(RESET_EVENT+0xff0000)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(1500)
	c:RegisterEffect(e1)
end
function c29303524.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c29303524.ctfilter(c,atk)
	return c:IsFaceup() and c:IsAttackBelow(atk) and c:IsControlerCanBeChanged(true)
end
function c29303524.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local atk=c:GetAttack()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c29303524.ctfilter(chkc,atk) end
	if chk==0 then return c:IsAbleToHand()
		and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)>0
		and Duel.IsExistingTarget(c29303524.ctfilter,tp,0,LOCATION_MZONE,1,nil,atk) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c29303524.ctfilter,tp,0,LOCATION_MZONE,1,1,nil,atk)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c29303524.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and Duel.SendtoHand(c,nil,REASON_EFFECT)~=0
		and c:IsLocation(LOCATION_HAND) and tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
