--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 星态龙  (ID: 41517789)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Dragon
-- Level 11
-- ATK 3200 | DEF 2800
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这张卡不用同调召唤不能特殊召唤。
-- ①：这张卡的同调召唤不会被无效化。
-- ②：在这张卡的同调召唤成功时双方不能把魔法·陷阱·怪兽的效果发动。
-- ③：这张卡攻击的场合，直到伤害步骤结束时不受其他卡的效果影响。
--[[ __CARD_HEADER_END__ ]]

--星態龍
function c41517789.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.synlimit)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e2)
	--summon success
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c41517789.sumsuc)
	c:RegisterEffect(e3)
	--immune
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetCondition(c41517789.immcon)
	e4:SetValue(c41517789.efilter)
	c:RegisterEffect(e4)
end
function c41517789.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO) then return end
	Duel.SetChainLimitTillChainEnd(aux.FALSE)
end
function c41517789.immcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c41517789.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
