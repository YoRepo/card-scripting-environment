--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 命运弯曲  (ID: 94662235)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧表示存在的怪兽只有名字带有「命运女郎」的怪兽的场合才能发动。魔法·陷阱卡的发动，怪兽的召唤的其中1个无效，那张卡从游戏中除外。这个回合的结束阶段时，这个效果从游戏中除外的卡回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--運命湾曲
function c94662235.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(c94662235.condition1)
	e1:SetTarget(c94662235.target1)
	e1:SetOperation(c94662235.activate1)
	c:RegisterEffect(e1)
	--Activate(effect)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c94662235.condition2)
	e2:SetTarget(aux.nbtg)
	e2:SetOperation(c94662235.activate2)
	c:RegisterEffect(e2)
end
function c94662235.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x31)
end
function c94662235.check(tp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	return g:IsExists(c94662235.cfilter,1,nil)
		and not g:IsExists(aux.NOT(c94662235.cfilter),1,nil)
end
function c94662235.condition1(e,tp,eg,ep,ev,re,r,rp)
	return aux.NegateSummonCondition() and c94662235.check(tp)
end
function c94662235.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:GetFirst():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
end
function c94662235.activate1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg:GetFirst())
	local ec=eg:GetFirst()
	if Duel.Remove(ec,POS_FACEUP,REASON_EFFECT)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCountLimit(1)
		e1:SetLabelObject(ec)
		e1:SetCondition(c94662235.retcon)
		e1:SetOperation(c94662235.retop)
		Duel.RegisterEffect(e1,tp)
		ec:RegisterFlagEffect(94662235,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	end
end
function c94662235.condition2(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and c94662235.check(tp)
end
function c94662235.activate2(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	if Duel.NegateActivation(ev) and ec:IsRelateToEffect(re) then
		if Duel.Remove(ec,POS_FACEUP,REASON_EFFECT)~=0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetCountLimit(1)
			e1:SetLabelObject(ec)
			e1:SetCondition(c94662235.retcon)
			e1:SetOperation(c94662235.retop)
			Duel.RegisterEffect(e1,tp)
			ec:RegisterFlagEffect(94662235,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
		end
	end
end
function c94662235.retcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tc:GetFlagEffect(94662235)~=0
end
function c94662235.retop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.SendtoHand(tc,nil,REASON_EFFECT)
end
