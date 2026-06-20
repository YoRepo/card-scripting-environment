--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 额外灵摆  (ID: 58308221)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 242
--
-- Effect Text:
-- ①：这个回合，自己在通常的灵摆召唤外加上只有1次，自己主要阶段可以从额外卡组把怪兽灵摆召唤。
--[[ __CARD_HEADER_END__ ]]

--EXP
function c58308221.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c58308221.target)
	e1:SetOperation(c58308221.activate)
	c:RegisterEffect(e1)
end
function c58308221.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,58308221)==0 end
end
function c58308221.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58308221,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_PENDULUM_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetCountLimit(1,58308221)
	e1:SetValue(c58308221.pendvalue)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,58308221,RESET_PHASE+PHASE_END,0,1)
end
function c58308221.pendvalue(e,c)
	return c:IsLocation(LOCATION_EXTRA)
end
