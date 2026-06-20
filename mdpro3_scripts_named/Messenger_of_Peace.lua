--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 和平使者  (ID: 44656491)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 场上表侧表示存在的攻击力1500以上的怪兽不能攻击宣言。这张卡的控制者在每次自己的准备阶段支付100基本分。或者不支付100基本分让这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--平和の使者
function c44656491.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c44656491.atktarget)
	c:RegisterEffect(e2)
	--maintain
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c44656491.mtcon)
	e3:SetOperation(c44656491.mtop)
	c:RegisterEffect(e3)
end
function c44656491.atktarget(e,c)
	return c:GetAttack()>=1500
end
function c44656491.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c44656491.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckLPCost(tp,100) and Duel.SelectYesNo(tp,aux.Stringid(44656491,0)) then
		Duel.PayLPCost(tp,100)
	else
		Duel.Destroy(e:GetHandler(),REASON_COST)
	end
end
