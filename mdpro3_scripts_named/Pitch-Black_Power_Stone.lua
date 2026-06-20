--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 漆黑的能量石  (ID: 34029630)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这张卡发动的场合，给这张卡放置3个魔力指示物来发动。
-- ①：自己回合1次，以可以放置魔力指示物的场上1张其他卡为对象才能发动。这张卡1个魔力指示物取除，给作为对象的卡放置1个魔力指示物。
-- ②：这张卡的魔力指示物全部被取除的场合这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--漆黒のパワーストーン
function c34029630.initial_effect(c)
	c:EnableCounterPermit(0x1)
	--special counter permit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_COUNTER_PERMIT+0x1)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c34029630.ctpermit)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetTarget(c34029630.target)
	e2:SetOperation(c34029630.operation)
	c:RegisterEffect(e2)
	--counter
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(34029630,1))
	e3:SetCategory(CATEGORY_COUNTER)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1)
	e3:SetCondition(c34029630.condition)
	e3:SetTarget(c34029630.target2)
	e3:SetOperation(c34029630.operation)
	c:RegisterEffect(e3)
	--self destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EFFECT_SELF_DESTROY)
	e4:SetCondition(c34029630.descon)
	c:RegisterEffect(e4)
end
function c34029630.ctpermit(e)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_SZONE) and c:IsStatus(STATUS_CHAINING)
end
function c34029630.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c34029630.filter(chkc) end
	local c=e:GetHandler()
	if chk==0 then return Duel.IsCanAddCounter(tp,0x1,3,c) end
	c:AddCounter(0x1,3)
	if Duel.GetTurnPlayer()==tp and c:IsCanRemoveCounter(tp,0x1,1,REASON_EFFECT)
		and Duel.IsExistingTarget(c34029630.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c)
		and Duel.SelectYesNo(tp,aux.Stringid(34029630,0)) then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COUNTER)
		Duel.SelectTarget(tp,c34029630.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,c)
		c:RegisterFlagEffect(34029630,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	else
		e:SetProperty(0)
	end
end
function c34029630.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and c:IsCanRemoveCounter(tp,0x1,1,REASON_EFFECT) and tc:IsCanAddCounter(0x1,1) then
		c:RemoveCounter(tp,0x1,1,REASON_EFFECT)
		tc:AddCounter(0x1,1)
	end
end
function c34029630.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c34029630.filter(c)
	return c:IsFaceup() and c:IsCanAddCounter(0x1,1)
end
function c34029630.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c34029630.filter(chkc) end
	if chk==0 then return e:GetHandler():GetFlagEffect(34029630)==0 and e:GetHandler():IsCanRemoveCounter(tp,0x1,1,REASON_EFFECT)
		and Duel.IsExistingTarget(c34029630.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(34029630,2))
	Duel.SelectTarget(tp,c34029630.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
end
function c34029630.descon(e)
	return e:GetHandler():GetCounter(0x1)==0
end
