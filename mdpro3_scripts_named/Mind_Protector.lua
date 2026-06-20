--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 精神防护者  (ID: 85060248)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Psychic
-- Level 3
-- ATK 0 | DEF 2200
--
-- Effect Text:
-- 这张卡的控制者在每次自己的准备阶段支付500基本分。这个时候不支付500基本分的场合这张卡破坏。只要这张卡在场上表侧表示存在，念动力族怪兽以外的攻击力2000以下的怪兽不能攻击宣言。
--[[ __CARD_HEADER_END__ ]]

--メンタルプロテクター
function c85060248.initial_effect(c)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c85060248.atktarget)
	c:RegisterEffect(e2)
	--maintain
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c85060248.mtcon)
	e3:SetOperation(c85060248.mtop)
	c:RegisterEffect(e3)
end
function c85060248.atktarget(e,c)
	return not c:IsRace(RACE_PSYCHO) and c:IsAttackBelow(2000)
end
function c85060248.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c85060248.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckLPCost(tp,500) and Duel.SelectYesNo(tp,aux.Stringid(85060248,0)) then
		Duel.PayLPCost(tp,500)
	else
		Duel.Destroy(e:GetHandler(),REASON_COST)
	end
end
