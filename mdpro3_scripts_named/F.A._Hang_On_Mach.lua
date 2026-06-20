--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 方程式运动员 声速侧挂骑手  (ID: 93449450)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level 4
-- ATK 0 | DEF 1800
-- Setcode: 263
--
-- Effect Text:
-- ①：这张卡的攻击力上升这张卡的等级×300，不受原本的等级或者阶级比这张卡的等级低的对方怪兽发动的效果影响。
-- ②：「方程式运动员」魔法·陷阱卡的效果发动的场合才能发动（伤害步骤也能发动）。这张卡的等级上升1星。
-- ③：这张卡的等级是7星以上的场合，被送去对方墓地的卡不去墓地而除外。
--[[ __CARD_HEADER_END__ ]]

--F.A.ハングオンマッハ
function c93449450.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c93449450.atkval)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c93449450.immval)
	c:RegisterEffect(e2)
	--lv up
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(93449450,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,EFFECT_COUNT_CODE_CHAIN)
	e3:SetCondition(c93449450.lvcon)
	e3:SetOperation(c93449450.lvop)
	c:RegisterEffect(e3)
	--redirect
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c93449450.excon)
	e4:SetTarget(c93449450.extg)
	e4:SetTargetRange(0,LOCATION_DECK)
	e4:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e4)
end
function c93449450.atkval(e,c)
	return c:GetLevel()*300
end
function c93449450.immval(e,te)
	if te:GetOwnerPlayer()~=e:GetHandlerPlayer() and te:IsActiveType(TYPE_MONSTER) and te:IsActivated() then
		local lv=e:GetHandler():GetLevel()
		local tc=te:GetHandler()
		if tc:GetRank()>0 then
			return tc:GetOriginalRank()<lv
		elseif tc:GetLevel()>0 then
			return tc:GetOriginalLevel()<lv
		else return false end
	else return false end
end
function c93449450.lvcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and re:GetHandler():IsSetCard(0x107)
end
function c93449450.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_UPDATE_LEVEL)
		e4:SetValue(1)
		e4:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e4)
	end
end
function c93449450.excon(e)
	return e:GetHandler():IsLevelAbove(7)
end
function c93449450.extg(e,c)
	return c:GetOwner()~=e:GetHandlerPlayer()
end
