--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 炸弹防御  (ID: 88928798)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 持有「把自己场上存在的1只怪兽破坏的效果」的卡发动时才能发动。那个发动无效并破坏。并且再给与对方基本分500分伤害。
--[[ __CARD_HEADER_END__ ]]

--ボム・ガード
function c88928798.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c88928798.condition)
	e1:SetTarget(c88928798.target)
	e1:SetOperation(c88928798.activate)
	c:RegisterEffect(e1)
end
function c88928798.condition(e,tp,eg,ep,ev,re,r,rp)
	if not (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) or not Duel.IsChainNegatable(ev) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local gc=g:GetFirst()
	if not gc:IsControler(tp) or not gc:IsLocation(LOCATION_MZONE) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tg:GetCount()==1 and tg:GetFirst()==gc
end
function c88928798.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c88928798.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
	Duel.BreakEffect()
	Duel.Damage(1-tp,500,REASON_EFFECT)
end
