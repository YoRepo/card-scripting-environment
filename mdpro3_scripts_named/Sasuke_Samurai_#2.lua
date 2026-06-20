--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 言语道断侍  (ID: 11760174)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level 1
-- ATK 200 | DEF 300
--
-- Effect Text:
-- 支付800基本分。到本回合结束阶段为止，所有的魔法·陷阱卡都不能发动。
--[[ __CARD_HEADER_END__ ]]

--言語道断侍
function c11760174.initial_effect(c)
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11760174,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c11760174.cost)
	e1:SetTarget(c11760174.target)
	e1:SetOperation(c11760174.operation)
	c:RegisterEffect(e1)
end
function c11760174.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c11760174.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,11760174)==0 end
end
function c11760174.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,1)
	e1:SetValue(c11760174.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,11760174,RESET_PHASE+PHASE_END,0,1)
end
function c11760174.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
