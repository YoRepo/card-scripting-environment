--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 糖果屋  (ID: 79922118)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：对方准备阶段才能发动。对方场上的全部怪兽的攻击力上升600。那之后，对方场上的攻击力2500以上的怪兽全部破坏，自己回复破坏的怪兽数量×500基本分。
--[[ __CARD_HEADER_END__ ]]

--おかしの家
function c79922118.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destory
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DESTROY+CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1,79922118)
	e2:SetCondition(c79922118.descon)
	e2:SetTarget(c79922118.destg)
	e2:SetOperation(c79922118.desop)
	c:RegisterEffect(e2)
end
function c79922118.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c79922118.filter(c)
	return c:IsFaceup()
end
function c79922118.desfilter(c)
	return c:IsFaceup() and c:IsAttackAbove(2500)
end
function c79922118.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79922118.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c79922118.desfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c79922118.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c79922118.filter,tp,0,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(600)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
	local dg=Duel.GetMatchingGroup(c79922118.desfilter,tp,0,LOCATION_MZONE,nil)
	if dg:GetCount()>0 then
		Duel.BreakEffect()
		local ct=Duel.Destroy(dg,REASON_EFFECT)
		Duel.Recover(tp,ct*500,REASON_EFFECT)
	end
end
