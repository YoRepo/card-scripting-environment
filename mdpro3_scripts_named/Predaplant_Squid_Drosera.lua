--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 捕食植物 鱿鱼茅膏菜  (ID: 69105797)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Plant
-- Level 2
-- ATK 800 | DEF 400
-- Setcode: 4339
--
-- Effect Text:
-- ①：把这张卡从手卡送去墓地，以自己场上1只表侧表示怪兽为对象才能发动。这个回合，那只怪兽可以向有捕食指示物放置的对方怪兽全部各作1次攻击。
-- ②：表侧表示的这张卡从场上离开的场合发动。给对方场上的特殊召唤的怪兽全部各放置1个捕食指示物。有捕食指示物放置的2星以上的怪兽的等级变成1星。
--[[ __CARD_HEADER_END__ ]]

--捕食植物スキッド・ドロセーラ
function c69105797.initial_effect(c)
	--attack all
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69105797,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c69105797.condition)
	e1:SetCost(c69105797.cost)
	e1:SetTarget(c69105797.target)
	e1:SetOperation(c69105797.operation)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c69105797.ccon)
	e2:SetOperation(c69105797.cop)
	c:RegisterEffect(e2)
end
function c69105797.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c69105797.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c69105797.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c69105797.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ATTACK_ALL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(c69105797.atkfilter)
		tc:RegisterEffect(e1)
	end
end
function c69105797.atkfilter(e,c)
	return c:GetCounter(0x1041)>0
end
function c69105797.ccon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP)
end
function c69105797.cfilter(c)
	return c:IsFaceup() and c:IsSummonType(SUMMON_TYPE_SPECIAL) and c:IsCanAddCounter(0x1041,1)
end
function c69105797.cop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c69105797.cfilter,tp,0,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		tc:AddCounter(0x1041,1)
		if tc:IsLevelAbove(2) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetCondition(c69105797.lvcon)
			e1:SetValue(1)
			tc:RegisterEffect(e1)
		end
		tc=g:GetNext()
	end
end
function c69105797.lvcon(e)
	return e:GetHandler():GetCounter(0x1041)>0
end
