--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 铁蝎  (ID: 13599884)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 1
-- ATK 250 | DEF 300
--
-- Effect Text:
-- 机械族以外的怪兽攻击这张卡的场合，那只怪兽（以对方的回合来数）第3个回合的回合结束时破坏。
--[[ __CARD_HEADER_END__ ]]

--鉄のサソリ
function c13599884.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13599884,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c13599884.condition)
	e1:SetOperation(c13599884.operation)
	c:RegisterEffect(e1)
end
function c13599884.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttackTarget() and not Duel.GetAttacker():IsRace(RACE_MACHINE)
end
function c13599884.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if tc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetRange(LOCATION_MZONE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetCondition(c13599884.descon)
		e1:SetOperation(c13599884.desop)
		e1:SetLabel(0)
		e1:SetOwnerPlayer(tp)
		tc:RegisterEffect(e1)
	end
end
function c13599884.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetOwnerPlayer()~=Duel.GetTurnPlayer()
end
function c13599884.desop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	ct=ct+1
	e:SetLabel(ct)
	e:GetOwner():SetTurnCounter(ct)
	if ct==3 then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
