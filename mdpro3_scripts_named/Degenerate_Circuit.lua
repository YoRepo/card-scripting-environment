--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 缩退回路  (ID: 36995273)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 只要这张卡在场上存在，从场上回到手卡的怪兽卡不回到手卡从游戏中除外。这张卡的控制者在每次自己的准备阶段支付500基本分。这个时候不能支付500基本分的场合这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--縮退回路
function c36995273.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_TO_HAND_REDIRECT)
	e2:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e2:SetTarget(c36995273.rmtg)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
	--cost
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCountLimit(1)
	e3:SetCondition(c36995273.costcon)
	e3:SetOperation(c36995273.costop)
	c:RegisterEffect(e3)
end
function c36995273.rmtg(e,c)
	return c:IsLocation(LOCATION_MZONE) or bit.band(c:GetOriginalType(),TYPE_MONSTER)~=0
end
function c36995273.costcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c36995273.costop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckLPCost(tp,500) then
		Duel.PayLPCost(tp,500)
	else
		Duel.Destroy(e:GetHandler(),REASON_COST)
	end
end
