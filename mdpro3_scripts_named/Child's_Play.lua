--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 大胆无敌  (ID: 12021072)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：每次对方把怪兽召唤·反转召唤·特殊召唤，自己回复300基本分。
-- ②：自己基本分是10000以上的场合，自己怪兽不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--大胆無敵
function c12021072.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c12021072.reccon)
	e2:SetOperation(c12021072.recop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--indes
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetCondition(c12021072.indcon)
	e5:SetValue(1)
	c:RegisterEffect(e5)
end
function c12021072.cfilter(c,tp)
	return c:IsSummonPlayer(tp)
end
function c12021072.reccon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c12021072.cfilter,1,nil,1-tp)
end
function c12021072.recop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,12021072)
	Duel.Recover(tp,300,REASON_EFFECT)
end
function c12021072.indcon(e)
	return Duel.GetLP(e:GetHandlerPlayer())>=10000
end
