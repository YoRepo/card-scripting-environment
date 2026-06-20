--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 王宫的敕命  (ID: 61740673)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这张卡的控制者在每次双方的准备阶段支付700基本分。不能支付700基本分的场合这张卡破坏。
-- ①：只要这张卡在魔法与陷阱区域存在，场上的全部魔法卡的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--王宮の勅命
function c61740673.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e2:SetTarget(c61740673.distarget)
	c:RegisterEffect(e2)
	--disable effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c61740673.disoperation)
	c:RegisterEffect(e3)
	--maintain
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetOperation(c61740673.mtop)
	c:RegisterEffect(e4)
end
function c61740673.distarget(e,c)
	return c~=e:GetHandler() and c:IsType(TYPE_SPELL)
end
function c61740673.disoperation(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if bit.band(tl,LOCATION_SZONE)~=0 and re:IsActiveType(TYPE_SPELL) then
		Duel.NegateEffect(ev)
	end
end
function c61740673.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckLPCost(tp,700) then
		Duel.PayLPCost(tp,700)
	else
		Duel.Destroy(e:GetHandler(),REASON_COST)
	end
end
