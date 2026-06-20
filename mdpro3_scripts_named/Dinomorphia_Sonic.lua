--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 恐啡肽狂龙音速  (ID: 52807032)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 371
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己场上有「恐啡肽狂龙」怪兽存在，对方把魔法·陷阱卡发动时，把基本分支付一半才能发动。那个发动无效并破坏。那之后，选自己场上1只「恐啡肽狂龙」怪兽破坏。
-- ②：自己基本分是2000以下，自己要受到战斗伤害的伤害计算时，把墓地的这张卡除外才能发动。那次战斗发生的对自己的战斗伤害变成0。
--[[ __CARD_HEADER_END__ ]]

--ダイノルフィア・ソニック
function c52807032.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,52807032+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c52807032.condition)
	e1:SetCost(c52807032.cost)
	e1:SetTarget(c52807032.target)
	e1:SetOperation(c52807032.operation)
	c:RegisterEffect(e1)
	--negate damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c52807032.damcon)
	e2:SetCost(aux.bfgcost)
	e2:SetOperation(c52807032.damop)
	c:RegisterEffect(e2)
end
function c52807032.cfilter(c)
	return c:IsSetCard(0x173) and c:IsFaceup()
end
function c52807032.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c52807032.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and rp==1-tp
end
function c52807032.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c52807032.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c52807032.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c52807032.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,c52807032.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.Destroy(g,REASON_EFFECT)
		end
	end
end
function c52807032.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=2000 and Duel.GetBattleDamage(tp)>0
end
function c52807032.damop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
