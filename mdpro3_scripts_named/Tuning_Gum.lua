--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 调和口香糖  (ID: 82744076)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Fiend
-- Level 1
-- ATK 400 | DEF 1200
--
-- Effect Text:
-- 「调和口香糖」的①的效果1回合只能使用1次。
-- ①：以自己场上1只表侧表示怪兽为对象才能发动。这个回合，那只表侧表示怪兽当作调整使用。这个效果发动的回合，自己不用同调怪兽不能攻击。
-- ②：只以自己场上的同调怪兽1只为对象的魔法·陷阱·怪兽的效果发动时，把墓地的这张卡除外才能发动。那个发动无效。
--[[ __CARD_HEADER_END__ ]]

--チューニングガム
function c82744076.initial_effect(c)
	--tuner
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82744076,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,82744076)
	e1:SetCost(c82744076.cost)
	e1:SetTarget(c82744076.target)
	e1:SetOperation(c82744076.operation)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(82744076,1))
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCondition(c82744076.negcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c82744076.negtg)
	e2:SetOperation(c82744076.negop)
	c:RegisterEffect(e2)
	Duel.AddCustomActivityCounter(82744076,ACTIVITY_ATTACK,c82744076.counterfilter)
end
function c82744076.counterfilter(c)
	return c:IsType(TYPE_SYNCHRO)
end
function c82744076.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(82744076,tp,ACTIVITY_ATTACK)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_OATH+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTarget(c82744076.atklimit)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c82744076.atklimit(e,c)
	return not c:IsType(TYPE_SYNCHRO)
end
function c82744076.filter(c)
	return c:IsFaceup() and not c:IsType(TYPE_TUNER)
end
function c82744076.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c82744076.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c82744076.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c82744076.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c82744076.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_ADD_TYPE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(TYPE_TUNER)
		tc:RegisterEffect(e1)
	end
end
function c82744076.cfilter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c82744076.negcon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	return c82744076.cfilter(tc,tp) and Duel.IsChainNegatable(ev)
end
function c82744076.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c82744076.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
