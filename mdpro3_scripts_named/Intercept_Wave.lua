--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 妨害电波  (ID: 39440937)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 双方场上存在的同调怪兽全部变成守备表示，结束阶段时场上表侧表示存在的同调怪兽全部回到额外卡组。
--[[ __CARD_HEADER_END__ ]]

--妨害電波
function c39440937.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c39440937.target)
	e1:SetOperation(c39440937.activate)
	c:RegisterEffect(e1)
end
function c39440937.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsType(TYPE_SYNCHRO) and c:IsCanChangePosition()
end
function c39440937.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c39440937.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c39440937.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c39440937.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c39440937.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 and Duel.ChangePosition(g,POS_FACEUP_DEFENSE)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetCondition(c39440937.tdcon)
		e1:SetOperation(c39440937.tdop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c39440937.tdfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsAbleToExtra()
end
function c39440937.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c39440937.tdfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c39440937.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c39440937.tdfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SendtoDeck(g,nil,SEQ_DECKTOP,REASON_EFFECT)
end
