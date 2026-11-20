--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-19T23:32:31
-- Source DB: test-release.cdb
-- Card: Lethargisaurus  (ID: 101307040)
-- Type: Monster / Effect / Synchro
-- Attribute: WATER
-- Race: Sea Serpent
-- Level: 8
-- ATK 1000 | DEF 2100
-- Scope: OCG
--
-- Effect Text:
-- 1 Defense Position Tuner + 1+ Defense Position non-Tuners
-- If this card is Special Summoned in Attack Position: Change it to Defense Position. This Defense
-- Position card gains these effects.
-- ● Change all face-up monsters on the field to Defense Position.
-- ● Neither player can activate cards or effects in response to the activation of their own cards or
-- effects.
-- ● Once per turn, during the End Phase: Each player gains 500 LP for each Defense Position monster
-- they control.
--[[ __CARD_HEADER_END__ ]]

--ダラダラサウルス
local s,id,o=GetID()
function s.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,s.matfilter,aux.NonTuner(s.matfilter),1)
	c:EnableReviveLimit()
	--pos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(s.poscon)
	e1:SetTarget(s.postg)
	e1:SetOperation(s.posop)
	c:RegisterEffect(e1)
	--pos
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_POSITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(s.poscon2)
	e2:SetTarget(s.postg2)
	e2:SetValue(POS_FACEUP_DEFENSE)
	c:RegisterEffect(e2)
	--act limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(s.poscon2)
	e3:SetOperation(s.chainop)
	c:RegisterEffect(e3)
	--recover
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,1))
	e4:SetCategory(CATEGORY_RECOVER)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCountLimit(1)
	e4:SetCondition(s.poscon2)
	e4:SetTarget(s.rectg)
	e4:SetOperation(s.recop)
	c:RegisterEffect(e4)
end
function s.matfilter(c)
	return c:IsOnField() and c:IsPosition(POS_DEFENSE)
end
function s.poscon(e)
	return e:GetHandler():IsAttackPos()
end
function s.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function s.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsAttackPos() and c:IsRelateToChain() then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
function s.poscon2(e)
	return e:GetHandler():IsDefensePos()
end
function s.postg2(e,c)
	return c:IsFaceup()
end
function s.chainop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimit(s.chainlm(ep))
end
function s.chainlm(p)
	return function(e,rp,tp)
		return tp~=p
	end
end
function s.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local rec1=Duel.GetMatchingGroupCount(Card.IsDefensePos,tp,LOCATION_MZONE,0,nil)*500
	local rec2=Duel.GetMatchingGroupCount(Card.IsDefensePos,tp,0,LOCATION_MZONE,nil)*500
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,PLAYER_ALL,rec1+rec2)
end
function s.recop(e,tp,eg,ep,ev,re,r,rp)
	local rec1=Duel.GetMatchingGroupCount(Card.IsDefensePos,tp,LOCATION_MZONE,0,nil)*500
	local rec2=Duel.GetMatchingGroupCount(Card.IsDefensePos,tp,0,LOCATION_MZONE,nil)*500
	Duel.Recover(tp,rec1,REASON_EFFECT,true)
	Duel.Recover(1-tp,rec2,REASON_EFFECT,true)
	Duel.RDComplete()
end
