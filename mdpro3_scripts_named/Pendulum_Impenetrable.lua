--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 灵摆延缓  (ID: 60434189)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 242
--
-- Effect Text:
-- ①：这个回合，自己以及对方的灵摆区域的卡不会被对方的效果破坏，以灵摆区域的卡为对象的对方发动的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--ペンデュラム・モラトリアム
function c60434189.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c60434189.activate)
	c:RegisterEffect(e1)
end
function c60434189.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetTargetRange(LOCATION_PZONE,LOCATION_PZONE)
	e1:SetValue(aux.indoval)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetCondition(c60434189.discon)
	e2:SetOperation(c60434189.disop)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c60434189.indfilter(c)
	return c:IsLocation(LOCATION_PZONE)
end
function c60434189.discon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsExists(c60434189.indfilter,1,nil) and ep~=tp
end
function c60434189.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
