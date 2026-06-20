--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 雾动机龙·角龙  (ID: 37752990)
-- Type: Monster / Effect / Pendulum
-- Attribute: WATER
-- Race: Machine
-- Level 5
-- Pendulum Scales: L3 / R3
-- ATK 2100 | DEF 400
-- Setcode: 216
--
-- Effect Text:
-- ←3 【灵摆】 3→
-- ①：这张卡以外的自己场上的「雾动机龙」卡被战斗或者对方的效果破坏的场合，可以作为代替把这张卡破坏。
-- 【怪兽效果】
-- ①：自己场上的怪兽只有「雾动机龙·角龙」以外的「雾动机龙」怪兽的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ダイナミスト・ケラトプス
function c37752990.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTarget(c37752990.reptg)
	e2:SetValue(c37752990.repval)
	e2:SetOperation(c37752990.repop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SPSUMMON_PROC)
	e3:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(LOCATION_HAND)
	e3:SetCondition(c37752990.spcon)
	c:RegisterEffect(e3)
end
function c37752990.filter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsOnField() and c:IsSetCard(0xd8)
		and (c:IsReason(REASON_BATTLE) or (c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp)) and not c:IsReason(REASON_REPLACE)
end
function c37752990.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return eg:IsExists(c37752990.filter,1,c,tp)
		and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED) end
	return Duel.SelectEffectYesNo(tp,c,96)
end
function c37752990.repval(e,c)
	return c37752990.filter(c,e:GetHandlerPlayer())
end
function c37752990.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end
function c37752990.cfilter(c)
	return c:IsFacedown() or c:IsCode(37752990) or not c:IsSetCard(0xd8)
end
function c37752990.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)>0
		and not Duel.IsExistingMatchingCard(c37752990.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
